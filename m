Return-Path: <linux-kernel+bounces-439578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B489EB14D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DA16339B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130931AAA06;
	Tue, 10 Dec 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xc5zV2us"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF851AA1E6;
	Tue, 10 Dec 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835264; cv=fail; b=BIBjDVV1yTqMaKj8oRrFbe90qtA/3iQiE0ccNftLFlsyXDKqpw5frMg92LVppu1UXLcAyxBKOEh9ml/55sEDvrLO31ibJXXrWyJR1t2dpxtoNct2MgUGB7t7APEQzyE8Wsmi5NXxtr5cSs13vEZ7Ih/MbH8JXgSeunjOLVVbtT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835264; c=relaxed/simple;
	bh=2a5yJBJ120np4+exzKmolIE0f08eNxuQizb/IKZY/d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeiZ7cQd/wbg5lnh21BhgY/M7wizHkoNZ5bEQvWZmixgPzAeI65UlcEtUSVWMAEpORpnKQu2i/PimcDY/ACREs7MyqDtDvqvlvSiaTrerihsRiULgq1vh6yMldtlLg/xecy/TsRC+KpXVKs8pGApRZYKaiM8dFf1zdGbViXQq00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xc5zV2us; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6I4sOhXWNhQXojVf//0qfd95hG+O5bGZqiA/EZmagxO1zA/QIfN3zLST7mK2QKTh2trhKiDUUAxyXdCqdHSMVx6tZ54wZ295A5tREgENQoMhSDRpLziAYUFtdWdxiywahElXOMqz1TqTYaeyhHp90vt/2fo2J4AW382y+o51hBAvhhbESntmSuvbL9OfspYiOrkIsiTROU+cFqfqEnhvZgyp3381t4a9eIZgBOpXkkAT5V5xXiugwcR87eZsHcun+HzyCVho7diXQQOdtSTwbkfZENHWmJnFnfJB/hBSIHiS7dujfZ4cUv5Sgkv1X3Fwa1+xGRg/n5cfoUtZ08x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFAHBZy4ZfeGfcdj4lEW7OAjAGzm+SGI5yjjwYwdE0A=;
 b=W8KlATZQi+OpxzRPSxBIlISp2TqinDx9JzdiGGRwCb4bMuX6z89CsTqtXNXRcDMjQgS25Oja6Rv/5K5rrNBKYEBRLWANjddLabBjkmnvvQL5hlzAGEpac4IvJBPZUacuRzvUzDnmPLIetYM/OPKl/tJv0x8x4D+9LZR0dWFgCmU/6XIT0VCe65HRHYhp2t8zP8XqVw8jmxTSzokyu1G+lghCuDMzV4Dh6kZU4U+KXmYUFOzhukguCSqnahhkSfQN/oPwTRLdrdoA1FoYE2qrWu3A+hP7E4+wijGhuCWFnoG2fnjtUfbo0a0IhkkuWnm8YANoNMkWjWssR5knKueRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFAHBZy4ZfeGfcdj4lEW7OAjAGzm+SGI5yjjwYwdE0A=;
 b=Xc5zV2usJA9BzGPAZ3u7rnjdEQkFJLQa9XTNvHV6UTwZvmrdSt+fGwQQxVQCPQ7QqxFPsd/czVpFpzKgOw2GiA76V2elaYLQUet7JbU20y88p0ubFkJrRYAhPN1gv/UilY/6GvonXO7cvoryaA+1brXZ2gFmwXwWqOp1kpxNqSUkfQ013S4KffDHFn9tqLcvbO2uOqKO7jFwkuhgNyR/yh8sXN7Qq+Mi9Sn4AbqH/LYPsFWGH78fNhaX17/F39R6fLpjAlIR/lXWCYZMbuVb7vFKbkOiNAmcHiv8uD6BmmN0FFc0JbdEgmQ9E1bYiVJgokLbwWKykhddxhcBQPU1kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:54:16 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:54:16 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 4/6] dt-bindings: clock: imx8mp: Add syscon compatible
Date: Tue, 10 Dec 2024 14:53:36 +0200
Message-Id: <20241210125338.104959-5-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210125338.104959-1-daniel.baluta@nxp.com>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e45f8b6-f6fb-48bc-97e5-08dd1919c141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gk8EBcp14OT2yB6NDz8/4D7s32Hf32/fSfsIL0LYEcTENmoq1nHm/yeRsin0?=
 =?us-ascii?Q?N4LtrrYj0wZlXueUZCYKHpQfp2DwXmHsz8e23dVFiZ1gk9WfKgq5cIoztz0K?=
 =?us-ascii?Q?7AbvMVjA8KreogAuSLcMlv/Gwsz/9dfVLM8A/sdR01Ivc2YtErB7Tc25Ndd7?=
 =?us-ascii?Q?wBvlxQ7e1UIXxkSKpDcrHJfe7U8ghMZJl8ejerBJRatqyVp+E1w80nozsQds?=
 =?us-ascii?Q?usoXsukRfanL1dxelSMpIGsFmybbOKNmRoXv8TmKwPwSpqeaLhoC4pBWB7F1?=
 =?us-ascii?Q?czKUEugig1fcfExbR6B8ftQt5D/JNlzd+SKP5Dno4ZtTt1QS/Rsj+D9AdIlj?=
 =?us-ascii?Q?c1U3bDyDFxoBy7SIrRjECdbtxu86M3DW/NN0Q4mL3mlKFhE8XuQ7RqoN/Krq?=
 =?us-ascii?Q?iSgxJ4iW4+9gTi/2psXIDfnN3B93PsJykvbWux/IQtjIvtilRvE7BimCiuoD?=
 =?us-ascii?Q?vwNutqfzcMDrmBf7xO5pbL4cuDJGysOSuSNoJYaGmkMZrjb2loQS8kmwAl/K?=
 =?us-ascii?Q?qDES1nDsrKvpKxDu+jQPF0/fM1U471RyYI9hVdduxMQUPAO+Z96CltAxYRhT?=
 =?us-ascii?Q?ud11DVwzrRqi9IeLVk6amZcuznwP12tgf/HCeJodcJExdK9VNogDLDme+aaP?=
 =?us-ascii?Q?YrgUuO38eNQj0swPCZyc9IffrbhrGGcDAiL1Fk5bmVaKiKH6LNkzFZVsUUeU?=
 =?us-ascii?Q?NXsqiJKoRqf5SNDPGkCTsAj+Nn/rp6B5B1l+AyWL1KBV/XlFmIi+5pyRwbhJ?=
 =?us-ascii?Q?8uTON+NveIhJgKxf6twcNP6/5cOAKGK/bIF7PqR3wCeajYcSW+h+sncNbbpj?=
 =?us-ascii?Q?PLmTetwKHd236CNJvPfhjzcbgeMPEMsbcDnynG3w0lQgMQ8F/eA7SxVz+vMk?=
 =?us-ascii?Q?bo1dgv4lSxrZWXV7bnPbTE/wvy67u5kj8c1c7Msc4eaGyNOnIehJHm1fIxSj?=
 =?us-ascii?Q?W2nD1O+UcVlncfwU/iApvup4Kg4EEwgpgBZxqTeIO3U5pmNmFyM9XeVIWsTK?=
 =?us-ascii?Q?vwpw4dT26IKlE7MZk1Anz1dfFJbIFIu+g8EPPLl6VaVdBv90KZ2JVj06BJrq?=
 =?us-ascii?Q?+2iuQhTUH1OGYy73xtBBAXXnXLdlz9P/BlkAvNtjTas4IkFMITiTSA4TmLF5?=
 =?us-ascii?Q?UfhHfM3SRsJssYBZfssY2XwoYL1uicz5aj7CbyJu2J6C1UlM7B4ByvVS70K+?=
 =?us-ascii?Q?s/I28D++dW5WTUmGsJZhg8g8uX3nzr9h8u2feyK+Jo96+JIYVZnVZVGX+kNw?=
 =?us-ascii?Q?C5cCQpQml0iMZh4HapDU5F8j8m945gTkD6sLzGjfgi75FmppMBrPsKQD9ViM?=
 =?us-ascii?Q?Usdqutnl7b9WvYjtV24HWxJOxRphpNLqdHlkfOJlqx0vjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJ1qcU8wD6WuTEQTnHP4FHaGFaniQhraI3/MF94ZcCGaXrDMhF2Y0KsHZKKJ?=
 =?us-ascii?Q?x10ups5q7rbDfuhc5C5ee73HZOU2xDw9jQKG3aFd/n6AoXoyUjqnZ8Ru6Mkf?=
 =?us-ascii?Q?wlOQH/SuQUaI3G3klDFYDYnEjl0ML7hvF0OylfEvIf6fQwkbZJFeA2r93aii?=
 =?us-ascii?Q?qSXzWjPJjw/Fc9JM4vDtV7ahZumQ/g3tadctS1mCGhEH6eDxY4j1xk50ACqC?=
 =?us-ascii?Q?mAT57CnqQQ1uiA/sqO8THZltbR49kQD6gjuk2x+WgWSuFhsshDsosIEL8vYv?=
 =?us-ascii?Q?NAxDd2cw+f79chw0TgmNqPooyt27Ac3nLLMFK1cYBBiTupslsfc+TVl0bt4a?=
 =?us-ascii?Q?oU4vC/Ob2ulEIyOOulkSX3gx/18QgzbRYGQReH+XytD6USTEkotRSNS6ULPl?=
 =?us-ascii?Q?imt0NfvHYjl2VL80EfDuJRBnb6U/iSjbHSjqiqJtJOG1Q/Y18W3H5f5YKlnU?=
 =?us-ascii?Q?2KOIiq/zCRzZAQMd6ezaUL/w5svkADzi8VEYnU2DGU04SU3oJ2bwBcrbUc5s?=
 =?us-ascii?Q?B0W7UGa1ekLa3F7qJsaSJpI6upOoc4bXhypKKScwEoD4dwnD6lD8C7w7moyW?=
 =?us-ascii?Q?1A0fS8PEW4sKicHauwCfAk8mzSnXtpSHLUy/43WigeerbChQvSc0eC4xl5LE?=
 =?us-ascii?Q?v334TRNNq0iB8vMfw7vyMNcJjkr/UGFBa8miSRSlCfDoFd/ya4xtFJLSjK7e?=
 =?us-ascii?Q?ILPeEGY1O7T83rm/A0/4oqbZ0wxEmQ3PD9c9IvfiQl2hB5bBW+yATUY+g9Ke?=
 =?us-ascii?Q?p4YVRWfdqPbPYv1WdKxznY0WRhC2uyVH7WAgCsLUWNm+AJfcXkjC866IEvBF?=
 =?us-ascii?Q?xp/3YsQlOFQZv+tiPyCQR+7hkHRiRtwJYDcHmjMdIgx0IdiEY/euRoZdahxA?=
 =?us-ascii?Q?dvrDyWl3ODE5ui6LwHBZ9rxo7+6kJg8CSjJG/mTgDsPws/ZxF17PdNb+nOqF?=
 =?us-ascii?Q?tgpEfhk6chySn2k7yMtZExmMi18WpzjwWCUWkgTxFOrjbTyVIjAy4xE/RvMF?=
 =?us-ascii?Q?HkwM054IuFZ8BPuT4DK2AUBVWXgOeWUu5zCOz3ZSWD2L4j375gMzDQ/A+F34?=
 =?us-ascii?Q?MOfM4W0XkXvr38hbNa89EhBxaQvuMQo5/jGkg0klIHB2KB0X9WhSeFF3A5H9?=
 =?us-ascii?Q?cTmIWkGDKubcU/d02pMVMOSzilV0alDHNEET5sXSC9FY9VNJF9Oa8H2aD7Pz?=
 =?us-ascii?Q?17TFkMwxcJzgY4Rjlpw0kEq2FIUXuP99cPOg1nvYi5FqtdC5ZK66+CBogJHw?=
 =?us-ascii?Q?PdWKlDY01or/h/7HCgfICgyhg+n9WIuAKs5S2SzrYcfiHeVYzQvvy7qeq/wY?=
 =?us-ascii?Q?rms5ODbE7zglCXAyBZ1TMbb2QxSyY7+hNox18DgZlLga6demcnwimfk+N80Z?=
 =?us-ascii?Q?HWisnH1t/L0VEANy6akOCcCOrwugXFdK6eW0iQ57id7/L/sBYjQlTI8J1XvU?=
 =?us-ascii?Q?xL3CxNtSwprhXtZnPGjL2icdI4q4Vg4xq0BoBiUuqkMGFDCTyko04HdzGARz?=
 =?us-ascii?Q?9xnJjaR/b9ljtJfVIuTTgcbLnKNWnBENG8qIBUaLJ9Qu10MRpSRvgVdNKZNg?=
 =?us-ascii?Q?bzFog6IRAyjrjgkIMk3qW0tWpC/Cy2zE+ik8fo2uN1GHwngxcanZ3nXBjggg?=
 =?us-ascii?Q?yC2Ym1Wi4m3bjeexW/MFIKFXYOOrnV4OHNXBj5oeL4xZMPWq//pMd+FnLbBF?=
 =?us-ascii?Q?zEsD1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e45f8b6-f6fb-48bc-97e5-08dd1919c141
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:54:16.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30sV8oOcqIcaN4ymW5UKcdLHkt5XZL/tv50MDo7D8qMFDctoFaSI1yDc2DN68KtPa/gdUn6T3D4bNIeIqu7lZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793

imx8mp audiomix contains a set of registers used to control
the DSP.

The dsp will use this to acquire o reference to audiomix registers
and handle the registers to control the dsp.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 6588a17a7d9a..0f870aaadba2 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx8mp-audio-blk-ctrl
+    items:
+      - const: fsl,imx8mp-audio-blk-ctrl
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -63,7 +65,7 @@ examples:
     #include <dt-bindings/clock/imx8mp-clock.h>
 
     clock-controller@30e20000 {
-        compatible = "fsl,imx8mp-audio-blk-ctrl";
+        compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
         reg = <0x30e20000 0x10000>;
         #clock-cells = <1>;
         clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
-- 
2.25.1


