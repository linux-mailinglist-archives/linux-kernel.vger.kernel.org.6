Return-Path: <linux-kernel+bounces-233850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3C91BE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFD71F24964
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C541581F3;
	Fri, 28 Jun 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LwF1cWWh"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EB158853;
	Fri, 28 Jun 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576422; cv=fail; b=trEu5vVG8NgdPV3rcKbpnBl0tF6cpE765ks5HXreU+IbXOg5PXsFJL4tAXzrHukRaQrmbEPiRIlAwyiLDVMVR96zbUZk3B+OqtuyGnT5ZOuGE6Zpq5cgOrhPqgV5UFWdDSIEG2sLyieBAAAf/BH3UmgCHSP8Zsb40vT0QIrmdok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576422; c=relaxed/simple;
	bh=K29XdoRFR2FDGbaxES3PQZBFEKZVqVKwnhMELUBKYwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ho609+1M2bcLK3G3UG8ELQnp7WMguY0irjY5nHRq99REplsdglkqoDjUDGCHmUvHL7d4j4qB4A1l/59MyqkrcX4oGFo5zs8on5cNx/q9VAgk96//GVLjdb+p8L8VePS8X0saX205nj2I2xgaNngnBqCFdyFdzyrbL9G5IAuXSEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LwF1cWWh; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxGYaz7tEvJlyAHClvreDu7uAUWwh/owxyulZSgtptVey+0ajyZAKHh7YR2eu1eptRZ9TJV1POHt4216KWX1ZMGL+CNL2KFUHHNSMLJCbclkRdjnS19NTTqk57h+Ja8dsb3w+bkyYLVYfpKeGFwQzqSAHW8xdM3kj8ZNU2Hk9XJrB+CYzgvfVES6lhH3CV2fraQx/LxC7Gc5zfKy1qiLKZE13yTwtqoHy6hi15IBGfV32HIT8g/YtSKTwe38Q+3ktT3bj7jisyqD+F21Motb6XeomElEGjsWgdEstwQQsIwB8nmHt2z+5UJ7osSvCwuws9jJ0RYI+1NpGe0wOvNzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLevH+XfKNFOCNQICsIgjlpHk4BLuS4gHoTgublAI3U=;
 b=oFrjiqHaynLjQACOU8O+7MBwwucmvfjy8hRLp44vna99zwaKKyTimV9bcfRN4YQkk277t0qYJWp27MvgtKtdGhvFQVqAAcMHpE2Ro8iv4MY8qCWhVQe8PQnIJLvFGxOuskfiyXpd3JqBKnkm6sUXI33qXAyKwrQR4ZDSspKTB0uJOLMWTqAr7FTQkpfg2yKZHL9jzmxvyc+aqgoecQOVHlfX7YP+3EZmzqzJxHlOTM4ea7gi1sHr0Xn0HCp/8mtlIOKBIYPuuoHLtDPzDYO0MBOA6GDuhlWwZXoXsV6gjl4UHrwMmeXjI7hkpJafiEKNMQm5MDSFPEni6MgpL41klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLevH+XfKNFOCNQICsIgjlpHk4BLuS4gHoTgublAI3U=;
 b=LwF1cWWh+GzO7ech0ZmVpcZhNJs/G5xatEnsQoFyxy/cIV0kT83rD49Zm38baRBwXmuiyRw8q+4drFyOCOd4jRhmCChjM4ZsST3n6KOZTEy/N/n/WRkeIjUQqeiGEFH9M5ttLACrBXCAzxMR/VIrDv5SS7htWz0qKzYkyHsk8uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 12:06:56 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 12:06:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx93: support i.MX93-14x14-EVK board
Date: Fri, 28 Jun 2024 20:15:42 +0800
Message-Id: <20240628121542.2000184-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240628121542.2000184-1-peng.fan@oss.nxp.com>
References: <20240628121542.2000184-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f858b71-aa25-4c75-199f-08dc976ace48
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5hbCEnaTYUyM6bl6yT4Hqtf9w1KZok06E2XOLSTbfG1KC7aXzXwUkjn0q/Gl?=
 =?us-ascii?Q?UXdYWGBEG1PsUfirJxnvJ3N4iNBJQqKCsn2dx/rTfDGa93v+mWFnisKm+ChX?=
 =?us-ascii?Q?tt6/t0R8rutDEzKKyiREvwv2v5JPoYz3+kMuGcy3dgfsznBu5gHupQOjSnM1?=
 =?us-ascii?Q?DDo/3t5VYr8ko3wgrvTOtTpKthv5vkwfof5M4YOIeRSh+lCQ4cv0795Nc0M1?=
 =?us-ascii?Q?1o6Irrtsi3FunepXKkNU5m0mqoBg4BCl1iuzFiXnCijkqAUEhjQQJXK+308J?=
 =?us-ascii?Q?bCAiDjG0/EuEBhOav0teKODencn1F/poUeVgwvaB3vgEZXyW8S9se9o7FJEB?=
 =?us-ascii?Q?clR7CrKoE1GdiFymzCBq8lrOgdJcWKAYDADmAr9emZI/EpaAhTJInXcr49F3?=
 =?us-ascii?Q?P2lYN4dFvDPdP9LGF0/wyIfbjQ2S6ZgAJmYXlG5AJq9EvlplJq46x7AqtQHw?=
 =?us-ascii?Q?wiKooS7Udsr2uShOqINkf4KwzUMSl5QKQfx2UnWz6A/pqathxk7RvL2Da1Fp?=
 =?us-ascii?Q?uXHw824BxOnHq0dRRt6O+YOT1knM+w4DX6i6pjzt4RvrLCdESV4ml9DaNSBK?=
 =?us-ascii?Q?ZO2sJ+tmZ5lB4vfZHd1ZkKrevAQJubDdLtPcucrjJtEbvPYuI1TbnGaFHYAL?=
 =?us-ascii?Q?qh50dTVgQp+cwlQEmj9LNx9U7Lp9tcnRNkHLGr9jw/jE/WUrUciT+fEkD3Kx?=
 =?us-ascii?Q?CLTjGJaF6bBTDj2ws9R3UPtfERj6LaX+U93ukSYNsNKsD1SFuNR+TQhLT6za?=
 =?us-ascii?Q?9q8CxA+nbdLHCAKQQffjRdgY67RWbcqNjFkg4utuIkbFHblNA6lBpxjPS9BL?=
 =?us-ascii?Q?VG1TFMrFGHX5XDbewis+2vHbf1Dn+Duliq3eoLkZZRLNmZyhbQP8vkY21o3D?=
 =?us-ascii?Q?Elc2zde2/LBx1p9V8rRruOd27RWybJvt0N0v+aorI7cz001NNCS6u8LxWjr+?=
 =?us-ascii?Q?m7rDqlYbIs9dAZv2HY8RStlC4oElrlvc2cEN9buQPlVMjLJ51cgqr/bX5iGc?=
 =?us-ascii?Q?0tQC0DeeCG+dgHrQXtf9br7RH9lyzFd7j1mx7Or0XIKQgurp9ggJEFuwGb0S?=
 =?us-ascii?Q?kWLrHnJDu+IBd8O+gu5Jm2UntTCnQED1ae0gRnGiz3RJ9KMPxq6+J63HtLsj?=
 =?us-ascii?Q?brWV7ZkCVyv+HY6N5ZOOBfl1/pYfHjjCT5BUsI+oAy6KB0MJ6DM7ZzHz2dKN?=
 =?us-ascii?Q?DOEzJOBhzR4ooFTTcFZA7601CFhMztNLG6V6V40n2Ne+hssCDSXGgl9XwoHU?=
 =?us-ascii?Q?t98Npjw0UGwJnOy5cyxzhqrVzHqfbKOz8dwJk95261H+JGjNZ6YQN+83Blev?=
 =?us-ascii?Q?8VchOOR3fTxQPi56UXJjx3UGBRfGXn5aoIV4VPCHHUwvdBfs8GDBUyeda0ru?=
 =?us-ascii?Q?QcubP8H4hIJ2f2jsi62rTFYIQYXJs4ICsLxQX6hOv57J3QKprA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+aMHPIf0hP2ANO8hKn4dwf3CLUpq594PaRCOvsqOZRlLVtCfuLU9HhRWjTu?=
 =?us-ascii?Q?HKw6ay/QiqbEdA+jtAQb8D3ShY/n6YEIvQrIIMCVq6pmV0dQvZ+w6vtpc10C?=
 =?us-ascii?Q?zJhGg3wPYy51ovUxzNGyygI4Dw9oojc2r9ggsqvvwuC2mbSifub4uWCwMg+H?=
 =?us-ascii?Q?XKyj4opAReGp0KF0DI2YqW7cOnxKv0rfIqBVEEl/mEGs44nYBRm4yqXYLac7?=
 =?us-ascii?Q?sRrHMOR5Een0Ci2u7bb7lFzNYozPVyYEWP9HW9mxfV8d4KgPqFs50DZuvUIq?=
 =?us-ascii?Q?ywdzSgqHUC89kNXeoGesK16XCngVhybspO2Wz1M0IIOvYAKUc+djKNCcXX0f?=
 =?us-ascii?Q?6qV37r/+OvTHX+JpRRrLJPJyyrYXf726uUd+so82E7JQnNd1rqfDiNlloCsb?=
 =?us-ascii?Q?LpDWGlvW0+n9etV3wqWLHvmbpg8CJdMajs7/ce9h3lfEKA7ZIRpF2L9wmqkU?=
 =?us-ascii?Q?/UWGo6a03Ehg36nVLPa1z7J1P50eAHH1Oe9o4r1Na62F2UuFRrYW7fXIJtGO?=
 =?us-ascii?Q?T/ar7EivEFmfC8cT2ns4MkFgQ/dKEQbwgotUi3Qon9IMn1csLak9DbHvmqRQ?=
 =?us-ascii?Q?kRuA9ournYStmjXZaUpd3rwiXZ9zeqa4+UnxzW09RKvrXbq/UaaNcR/qm/YA?=
 =?us-ascii?Q?r0/yUM6xEZ+Fq2lB9B648QxxcJFXQqiF5Dxe1hSXbNNyvPhkJhjQwUvnf6g+?=
 =?us-ascii?Q?fAn3SfS5PAzQpjTnu3JXFlW8Jqm8JQ9MktemL87eOsarnJvwTUG498+RjUlw?=
 =?us-ascii?Q?s5KE0DjDb8ttKL6HQ6Br8Gf6qo+d+tks5+OtobHhLxX+PNLQSf3aEkSUMNiz?=
 =?us-ascii?Q?t8BwNueGyqJWB5r64OarpFMc0ofH5/VCAKZQBFSTCR92zWY3bcf9auJA7Ys9?=
 =?us-ascii?Q?7FuAg8aQm3M3x+pfyQu9+QLPZ6rSXfqgAVB/n+pRspqBsAddkXRkrlL2SR0V?=
 =?us-ascii?Q?YN5JYxZKeLTFcj8GT44o8igUwdWEJ7CELfpVunICPp6PSpg8PI2eonVw8kv6?=
 =?us-ascii?Q?CwkyAi7wN5+LLbSxnLWSCYCkGHILCEHWQ63s5maqKvrpAH3zQcXh0waJij6Z?=
 =?us-ascii?Q?MIH5w7mJRbc52O8XefjezI04XTWjxq5W93oW7kBvQcGxXauEU3y25C6ZxSa9?=
 =?us-ascii?Q?BXZk1GwZHSCYHBFg0hTNc0vCeQkXo48SlltFyichWO41q40+tEP6yaffYPMK?=
 =?us-ascii?Q?r2p/8eLMwPbbxyXPga2tiymUdBPbBufzfWc9UX9jB0VuTdtM+6RlND11cOE3?=
 =?us-ascii?Q?7KC1RvJfc3d2eyHeoHYE5eYs/g6nC7G0xGSkdAd4mNzQg0U4yhDFPPsHFCXO?=
 =?us-ascii?Q?jfuQe5lc/V5SlChZ+Zh6j5MKofBFhpkHXG+DChDSd5BSdVMRI6f6WQ3KSRiA?=
 =?us-ascii?Q?Zjg8O/Ctrr1YB+qxHU2xQwJqTSmrxROyHH91pkUwhPpOcXrXvAtWB8CdDIPF?=
 =?us-ascii?Q?DGO0yJIpBckNhfNhxuga3bGTNXy6iRcoyaZd9yDxC03LuIB+JHkQq6ZaSwE2?=
 =?us-ascii?Q?Fb9xDayT4YVO6vtxZ3l4MoGB9HmPF2n+jNLe9CkJO/an3H3k8YzYI/3mNR+M?=
 =?us-ascii?Q?ZZtmHKXKZc9/PZzO2Y2fmDhthEcYwZ86ChzFUWS7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f858b71-aa25-4c75-199f-08dc976ace48
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:06:56.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daJYFnO+kFUQvvRw5ve838/D+24Z+XZO6qH+VRw00vGd7jKMgzGxvT4sSrf2Sie+A+QdKG4ngSKptAONGJOEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279

From: Peng Fan <peng.fan@nxp.com>

Add the board device tree with sdhc1/2, cm33, flexcan, mu, lpuart1,
lpi2c1/2, usb enabled and etc, which to support the i.MX 93 14x14
Evaluation kit that is an automotive market oriented evaluation board
with i.MX 93 application processors in a 14x14mm package.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-14x14-evk.dts    | 468 ++++++++++++++++++
 2 files changed, 469 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f04c22b7de72..41a7470e1c3f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -238,6 +238,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
new file mode 100644
index 000000000000..236a44c1782a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx93.dtsi"
+
+/ {
+	model = "NXP i.MX93 14X14 EVK board";
+	compatible = "fsl,imx93-14x14-evk", "fsl,imx93";
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
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4010000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524_2 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can1_en>;
+	};
+
+	reg_can1_en: regulator-can1-en {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524_2 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524_2 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can2_en>;
+	};
+
+	reg_can2_en: regulator-can2-en {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524_2 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
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
+		enable-active-high;
+		off-on-delay-us = <12000>;
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
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
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
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	lsm6dsm@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524_2: gpio@20 {
+		compatible = "nxp,pcal6524";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
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
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
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
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	no-mmc;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x58e
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+};
-- 
2.37.1


