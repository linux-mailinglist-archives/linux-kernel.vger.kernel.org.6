Return-Path: <linux-kernel+bounces-236972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668D91E938
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F1B216AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59202171088;
	Mon,  1 Jul 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MwVwAbDD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442617106E;
	Mon,  1 Jul 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864490; cv=fail; b=r/yk76cNyC2Ufz1lD+Z09r+vINe4qNE4V2S7r6lrwb8Fz0VqQB+dHaM/0WHskyqBNUAQKaBEIxkbbjFsLgj8nug6An8MNqXeJFcos8ANvz9cVZn8+u5pA49YQ+YmylFKwQTH7gPKfkwxHgr/N1Kgxzl/xQeywXYxPyENdHy7868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864490; c=relaxed/simple;
	bh=o+nFG7ntI85p8sSE6VTVcEylENt0gk0ZaLRzn5FBi4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pH0dWcS9h80/fuBiugpNlisnZDWFs5brjTA4U/cfWw0S8qoC8kALAb7BkIouKAyBX7F25Ms+dt9bcihr8Y4rOtiACKyMSBRtVT+KCtzH8aiD3WMuY7pqu89mP9YCvGDx/BnVDGX8QUt3mYC33bGTImrJfuHi5A+pIRYa5eMm76k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MwVwAbDD; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdi49yTw1iU0rDbvH6Eec+vXkITRL9hZBgvSasZDALauwvb1RWQHsBNSVMko6nerM+fzuVi1ryxn5FTBQOKnWubjCOuCtdJXQHlxCTX63GrERiu8FK9ts++L02l4vi0lqAPrMVAKOqVq+Xjo/jLGvATzc9QV7biZQtYY4b/CnQRYdaXPCok+UtZ3AK2pcypwfan1tpVMj7+0loiQkW79I8WQpbxbVGpCZINJBtKi0aAV6+hr26zG53/cTuRgKgPsmD7a8UEMdpCirrmB4ejgo65OKifUJj3kOxDuYNbaI4V8hqr/XeaG/DIqVGckukX2CL2VsCJf7zWcXemP05iedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhyh6JbBZoyQM0pGa/BUmWi+Wf45MTCDx326c9/TAMA=;
 b=LtaAqRKJErUXQy22m/eTmc3+vN42WrBN9dl+wRKyCywAsss6K2cPuVfiKIuBr41PSKLc+B7ay/jcVfcaPcAVxTXazfG2LysQHzTxQPYV1rbyhFSEx6XPmHefJJEOQW4sLUnbY5U/DtZZINQR4/klEdLL8Yr+n9j6MeagBeHw/zejEwKbFbdti7Fte2PIxRQjMXlPIrzQUwndZB0wJ5bKg9uu8NeGjKR5m7zipiKyA5YayRfQdCmzpIUftqxCmG9EuXnI6ME4bH1hk0boqn6NBdWBeTLr2oyRSYykuOk7W58QiTihAAi/LjsEPYR0lrmQOnu971u1q8lxr1UxTuBEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhyh6JbBZoyQM0pGa/BUmWi+Wf45MTCDx326c9/TAMA=;
 b=MwVwAbDD1ynUEJCXy84x0GenXdKdPu0ZT3CI4NHNMezNSIKFUamWUAjpHZpri/GlJnESpynEBV5btBjgmo9K0/SiLLjUyL4HCPQoXdbtnH0rcEWUKm5noyU/qFQAd4myJpM3TU983MOLEkyx4EVIPnZIIdaVnvG+BfNuywKb7TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:08:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:08:06 +0000
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
Subject: [PATCH v2 6/7] arm64: dts: imx95: add thermal_zone label
Date: Mon,  1 Jul 2024 16:07:27 -0400
Message-Id: <20240701200728.1887467-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab6a088-faba-4ea2-d66c-08dc9a098556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ctd56ZuOEM5qPnCsmq4c4l4Tk+tmRhqUDswys1sZQjRosJZ/w42LuTNOLYoU?=
 =?us-ascii?Q?IYzd4CB2J7fVv91Sd3vcJku+/aRdLR8MdPOJfDkzB3AUySJxyyOTgY58MT6w?=
 =?us-ascii?Q?v45Z2z715MHyrCgti2lpR4t7rsKjKe9ToOMZ+uaAiO51ay6u4hv4DBVRFOC3?=
 =?us-ascii?Q?CrWbWZT/nae84eLz754lgATAOe/wJRpBvTuRcw2ct+HTLiCmJuc9vdWvNXbI?=
 =?us-ascii?Q?h7QvDI/ECkKVTflQezcpdpoSg68Wx3XsF3MD5HqQ7OpuXvedwpIDeKCg0q/H?=
 =?us-ascii?Q?DBKE8MslM8Fsu96Z4FpDrCvcvR1M7fHeEWJFqEdml4PcoTcqK6TRvnfiDQ4y?=
 =?us-ascii?Q?e+Ow7gZClwsMXUTcJQQZHZDy1cprN6vtgvoj1EzNGmH5tnHOXfLTbTdMg+Qn?=
 =?us-ascii?Q?SJzSbkFlH/ahVxwCn2/mI9G2627X/hXclLRECIJIQajqQLMNbVnZA3pfWG2d?=
 =?us-ascii?Q?V5OCAcklP7wneRlQR12GLYgF6idbJ6GvfS9FQCzgKq9AymbQExZMXli2aOsp?=
 =?us-ascii?Q?bAopPEb7eK9e//mliXdN7UHTaKghrp45icJMg7Z2LVzI9vi5hH0DB5bpCsQb?=
 =?us-ascii?Q?hm9XwlkZYk+mHMgFREbL1o4DhdrU68xZQuMbb8FyO7VHNH40Y2g1YuxGlMje?=
 =?us-ascii?Q?xMYTXOOFOGwcn+hVeX/SIE0ZkzzD9oHwHrHCKe7u0r2KtzPyGq0dLCFjjsB3?=
 =?us-ascii?Q?/W4elFrQqboOSTRYlqyef1ewb/wfggWsiUxuYcuoo/CUoocaxFOLyLZShnB/?=
 =?us-ascii?Q?uZcrVq11KY1VEX+7TnmRdge6iFqM/wOXHb+Adp8f4+XyBXx5j4X0pB8BxXVJ?=
 =?us-ascii?Q?QJXPmnpy8pED9ooLvGeLpuY/7Kh7nXZWv1KFO9g3iTboZYjvRUU9K+hjnXfS?=
 =?us-ascii?Q?KXWWl/PIHeR5OCPNQD5fmOvOe0PaHmu1An7eNlSdCPYI1rE8fGTWJ14tovs1?=
 =?us-ascii?Q?1hmSZ1gVYtgk3MnycJ5uoTbXfUvsWhgc37gg5o6JJf2sGJMmGd/1+2qd4jDd?=
 =?us-ascii?Q?RynOKhRnxuO23R6m35PicoOpHbCNrWs6kYy95u//lyAZgTbryhd6jFuYlf1h?=
 =?us-ascii?Q?63AI/gxFopXfVR+C/xniugefcNMaPoMLnJZKnG1l8GJMcBccibv402fpcYUf?=
 =?us-ascii?Q?IYv26xvwWUzZzAcHr1YI5CUQcihpW862+CnqnuTnM8eHQOgPVBPiU3jEN2d9?=
 =?us-ascii?Q?h/Z967Hie7eB2gX8Wk9upMx6FbNn2tQ2tFS900dc0aZ8nfe8i2c/RvKBpMZc?=
 =?us-ascii?Q?VURP293AQV4exveXiRlknZV8+aMu0p5ZqKzQw7F1WYdSBoU5YI5k8+6NlXY3?=
 =?us-ascii?Q?xze0XNBQkh/sWEwCsqQ1y8evb3GgoiiV3vokFJieZbKbevDNpADKfM7dbf63?=
 =?us-ascii?Q?ZU2lTibIdYfSe9cKBHVs8erYGaB0ZLC1X0dJlE0DhdO60XowLB3PcCJdDkda?=
 =?us-ascii?Q?9sx9o4U0/4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+FWvdf9GIeRxOkQ6S4k7hdESK9+Cy6/IbLuBpcEi0HWLLPuom/5NVMBAzE/u?=
 =?us-ascii?Q?x/R/EzXenDo+Jponx6Uef51JMIyKPCYlLQbvLsny1lYPq1udTG9a77+IBQqd?=
 =?us-ascii?Q?a6BuDVzD335pInisEGae8FzBwtXfBO6IvTAPpRFIX193MKUGwdg57Xy/rQ77?=
 =?us-ascii?Q?yP5fjaR3xEJhIRlOGcCW/SkweddoKuYduXyC+5JALeW2rybaOho5D20KOGQ5?=
 =?us-ascii?Q?9U/m5dwasdA2zGpB4VCQWylS4BrPEP567lfNOmo1wbDJJ2SGN8d9oU/38V13?=
 =?us-ascii?Q?lHSiEa46150iMVrBm07doi8NxGQiWgfJ+bJ1T9IBhW9MWhMGMj+MKi8pd2Oj?=
 =?us-ascii?Q?D/2JtIxDHvzucoA3+K0viB/w7O8bAZ/OKFPCTHw9TSptT8VYoOejIhV+XdRI?=
 =?us-ascii?Q?tXfNefmVHYPq+VvHqkaaWVO4kAnWCrSp8Ux8V0NMw0GniXsZSfbGQ2DzpB0h?=
 =?us-ascii?Q?yyqUr+LQjTKIgGhjjG1jHUzXaxc7FDPGnhKbXQG4m1pa5LJwnM1llmJmqox6?=
 =?us-ascii?Q?zZzWyN9TqOIFlM4zMrePmEoAqzkwNZ1lgMw40gOugWgNdFfihJLIND40IyCe?=
 =?us-ascii?Q?Q/SskepFV4tom6B18/yyu1rxGnukR+fEdufg0R9hnYEBINj7KHIQjfN55qhc?=
 =?us-ascii?Q?qulv8/seB5NtX4YxErc96Uk+4jbAQZQUeWEIGdmq/+bz4UWSW45YQXMu4aYc?=
 =?us-ascii?Q?9DT7zRHhgNDOU7kpqJZzD8oXuJuD0BnhhBk2ojXp2zIAKmfN4XrUeT5rhTkc?=
 =?us-ascii?Q?ulztVsdibHj7lygReqgn9fZWIGgk1aRnMxZIry9UaGsnppBnF1sn8kX/MJtx?=
 =?us-ascii?Q?p1jpFhZGOqPFMg43N497Jwy53GOSpi4BUN69+qFfTcvDUhOhquvPbvpp+DIH?=
 =?us-ascii?Q?gLI2+udjHIw2krFdapIHDoElWmjVFTe7H8AyxlnRwY84FzugeDcxUnkRRo6E?=
 =?us-ascii?Q?4CJBKY4xzjLkpcrBQFrjUag0SOJXU6z3HiFLqwukF+eBMN1H4QcW+YMLewI6?=
 =?us-ascii?Q?qOwe6GOE7ODTbJWFAW1Q9U4D8h8znbrlvc1/DTDDYPtCR3uFFvwc3stV0vPG?=
 =?us-ascii?Q?a0OCTazrQ1FiHvNU7Qupax9hHHeMUO8SbLPK1qzEwrr0sQva9CrbpQf6lrfk?=
 =?us-ascii?Q?JJTXwGGuXscQyWgMBvlYCB1s4LCgGxLcw8rSI+FD1Ps2roLk52LJnSBLF1l3?=
 =?us-ascii?Q?950obBJzSaFUcCj3f/IKcFeJWzFv1WOa3jCh6L4WE5nrjFm5C4QenRjnjB7B?=
 =?us-ascii?Q?P7uF4B4XU6QHLcVUJbaApmHWE/SnqqgVm3l6JCzHpHYLtmOnOfVc88sncKFx?=
 =?us-ascii?Q?WpDBovEChQ1qX9a7Ttvo/yVoVogTW8V1B1tI97zZC9wLMTrfFt7asKFh6GZG?=
 =?us-ascii?Q?U4E60mFW4FqoB2J8ZT8OByVUeJyGjT9HjFiBILoQcfFrs2ukLsnGR3Ugcg4C?=
 =?us-ascii?Q?dHkcJ1byWpCipamWiTnEEVr06OJ7Pe0RSi6nYMx4mRzvCpKmX4qsKyGiZXWV?=
 =?us-ascii?Q?nw5r7ndCTo6b1//rh1GrGUBMafmtxEUmZVM65cA/x9l+QgpgPU/6T2tY0Hf0?=
 =?us-ascii?Q?/DCHplO8nTb3N+As2ipv+QhgENrM154bF57rIxpW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6a088-faba-4ea2-d66c-08dc9a098556
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:08:06.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWIVHZEUb1vlJeHrt3OK+prlM9YbdX/7PviW6TqLEPTY+3sWzDXtFNjRTsFjLQTr37qOqWhBmevnuejKQdkOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add thermal_zone label because it may be overwrite by board level dts file.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- add peng fan's review tag
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 0870c0d13e041..e454240ab3b04 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -326,7 +326,7 @@ pmu {
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	thermal-zones {
+	thermal_zones: thermal-zones {
 		a55-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-- 
2.34.1


