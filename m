Return-Path: <linux-kernel+bounces-287002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C7952174
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF86EB24DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F51BC09E;
	Wed, 14 Aug 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KKUpQXrC"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B41BBBE4;
	Wed, 14 Aug 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657486; cv=fail; b=S1RZR2Cz/nYLzicia39+gTzQsmIpIC3qUON5aZdYINRoeRu2QeIIkET9s0Zv72XyWbfe8lbsa8hI0Q3DT+7Xrq5CcG1RWnQTU8y1eDRAKx/cs//ZhCCpIps+3/jMT0GJgFB/Z8ZC8fvj4Nvd8TySWmss1lxae5knIIKuVyQYVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657486; c=relaxed/simple;
	bh=GqaWexS7SWUGAnzHdIhhxSCT9142w4YLwvHgzZyGxGY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=emcaeG+SZv1sCD2YI6DvbkW1MFzJDnJz7IeEi/m4lpBFONut9KUPnCqc2AMPIHr3KsKvQ4hjHdR5e5IQLKHtqKuD5BXYnDcRr4mvrggmlzukPYKTbzCrzIzspyftiPqdH8AWhZzVzhd5vlk/h6QlJZCYEL//f/Tzd36WLEg5uq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KKUpQXrC; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4AqUWVw6EHw959nlExmEjFCIEa590im2LZqq5fGWYYSB0rA369w05ldw+GaOhBmLbP0LV4pkrPQPFpunwDNv8iBp9hnTEJ/8NrghAaGY+JguQvna+CHkPMDxzYw8mJU6O4Mwf26aCqMNBsA4qnvNamIPYW/1sHuSO2DcqWskyK3Y9MJdR3kZqWaGSWDL6DqKB+IuwBtcPez/xrJ61eo87uodjiYTsvSobUezSPgAu8OCdKqWo1RKS0ghpaxelYqzaimdhVRYup0XP2TUuraDIkEPS3EVQ9ba7cttByW0UOdVkHeb5M+Gibg2Bd3Okgw19giwFF8uX9OyK6g8/yGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiUsNwHuUoROiSHft7XhTa06uCab4CsxMFHW2J7MGnQ=;
 b=u+HTUmm/uDSvZm+b2g1Shkul2UQ3ETrvbVAxPsUYwutIVnmRVT73L5pLSkqLf+Pe1hYNMvg74BUIVKk4B9NJSTSbx3Hgt0O+JsPbPT7rXYSCULgLyxmMe/aCwQWnhP7zsS9qYU9RgmzTI9OKUtav3ECyV7K37rNmL4vP3UuHrLxnj7f43YOMI+APcHRA3ewgktBtawLMqjP0jnLHefoH9Jx03CAGIDg9wf998UV92WWvabLkB7Oux1+ukFgzj53/Lp8RSOXsFQwvoZdYghISiSYttq+qyNDrTyjgrgAmTO23JdnBiZ5vgZEEOARVzBGeag93b5B8w8kc2dbonrOvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiUsNwHuUoROiSHft7XhTa06uCab4CsxMFHW2J7MGnQ=;
 b=KKUpQXrCbktnqyCJM6moXPJvugykpNwKfzCNL38x2fP43Fc3E0O0OlEKNwRWcut16uB/0ze9kzO73dr/QQqGmyf8u+g8aCNWgRjsIko8GCi9AFxCR/nVmYDcEsaTvqeC26SeTLye7JqX/MufxYQtC6oT+sf7/y5m6af0NlAdGXlNu8DmkW0RbWM+LxNE8EaJHH3IFHwPw0BuskkCkJ6snQ5IJ9ktByAH6sMvCbJ2Pw0WUawrapKvIYaLVAEhNLikMvP/aiMItImszbB4hlks1ALOFN9aevHJY/tME7nRJV4KaEJezIUVEIdMqKa2Bp8uXVjAtw8+W8IrjCuocD1hrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10606.eurprd04.prod.outlook.com (2603:10a6:150:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 17:44:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 17:44:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org (moderated list:TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml
Date: Wed, 14 Aug 2024 13:44:20 -0400
Message-Id: <20240814174422.4026100-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: b6888d02-eff4-4e8b-0004-08dcbc88c4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pQPWzCLzAyUC8RjVbMIjrvbMqTdXvjcz5PjGWA+D86+JWAnXbUzkUGWOsnT?=
 =?us-ascii?Q?iUbjd4ssC63b2I79oUxG5vKJwKLIu4s+ALt6/yehSf0K3TV2gBEGtk1Edp4K?=
 =?us-ascii?Q?KcIslK+X2mPxwiTrd6yPpayBBRGCJFEZXcemyDOny6hEa1QJzo/w83CAg6BQ?=
 =?us-ascii?Q?LfoHDstN+zIkBPTf+bQbYS1BZEnGaDuNVOdzZCgCFi9Tyb3b2WqEPYMk5w5J?=
 =?us-ascii?Q?0QVwVIf8IDiQZ6FUgr0lNj3TW+qrR+9+WevldLmuAPM8tsnSCUpEerASlRsX?=
 =?us-ascii?Q?dre7wDIhzXicpllzzPo4+VduOJ3vliTIiX8bwekP4B0zxsrI1g9dNmIUUlLD?=
 =?us-ascii?Q?zlwApb4SrXr+hWjFYVEMngeLPcSFqeSuKwM5phgkRPPA1i7YrjuqJ59+7luQ?=
 =?us-ascii?Q?l5zG6+1lzrfNUKwV+T3O5Lnn78HDoESqLZGXw3aqvS9LL6n7+jcQHaY/xISi?=
 =?us-ascii?Q?NUlvDbaBFm1Dstd5O154Nr1llADoYbhLGRA+b+Q88HF+IcgB4Cf/62cG89Cu?=
 =?us-ascii?Q?aWNyiW9u1UhWRfV6ImNnw7HOx1bDPAwdSCMXDtzUSvI8vAEE4lG/CdbKsSRh?=
 =?us-ascii?Q?3139gQdAZfBYVR6MGYRsZFYXotKiMHJJHZHTKnxU8G+w4G6Qeks36vF+gjFA?=
 =?us-ascii?Q?i6K+X18YDVtT/e9gi3k4ag4+tgW110Qvbiv/ogj4aVnvyrqz1iLAH/uWsrUm?=
 =?us-ascii?Q?DWToiWdPEqaqMS/kJfr6/G4jtM7RYg20Np4uV0tHgov8CXqYm/ERq7HgPr4N?=
 =?us-ascii?Q?2kFykdafrUDx4TjNLIzFg1PlVClUImWc+vy0BWcnbF5PY/irdivISo8NjWio?=
 =?us-ascii?Q?Rhy4eH5LdGKsdDFyY3tcpiJDAggbJUEZmVO1/pCeh5yZryjL69fUApshKQCD?=
 =?us-ascii?Q?wUBCw2ExDXcdB7QrirnZVPUrJBbJVTvvUX8eq3GKVWZR5vjoAaago9sJrnTK?=
 =?us-ascii?Q?lu382pizVue3r8axiriSrpqivnrliNxhfs2zyYyfxFBcUir4xNWOv2KcHzW4?=
 =?us-ascii?Q?9bfKnH5EvFBfL9fQ7GIJrQcKBvRdkxHCCL002a9wv2dtz8KoTrg/0jdNl8CH?=
 =?us-ascii?Q?od0HH7z4WTwZQDbNRr44IcI8oa/pS2OoAt/uAHqNUkqOMs7zTsVB09gvz1Gn?=
 =?us-ascii?Q?wiiRpDMDE2YWQIpgikJlyKKzUTFbmj4NvCcYigZVviYrD+KCbW0UGut7IxSG?=
 =?us-ascii?Q?xOKRRHJ4CbJy3T8zIvZU6BkDwH8UQBv1LgrxtVHX/143I26rmWnM8TlLR3qK?=
 =?us-ascii?Q?6dGkoNvpGbbLbUmuyvdVA91z8vb9UQLThjpjrfjPf7VouyZflEai/TuT6WBJ?=
 =?us-ascii?Q?58w3KI3Qe/10cjbxQjSGn4mjOcR2Cqe/N41byvMi1QUFtUZBR8zts4fglOGl?=
 =?us-ascii?Q?X4EbN/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZKXs2uRLpu22lLFxKy617dAphoWT7T0NpeD27sh+145uB548AcgSzhdAOhG?=
 =?us-ascii?Q?nZLaG73Sy7uBnDYEnNthUtUYo6okvKRaEpvXEGrNNjFCNwiSywTIoFMJTD4s?=
 =?us-ascii?Q?jowyv6e7YC8p7JX9RGHX5dbQyReWs0DHPHVKyvcUjqUQGzobFS6tywLGs3Le?=
 =?us-ascii?Q?ZOwIRpmPz39cHTBJXud7LSEuRjJdUIZhVTs/2nP6FU8Tdytul1/U6LLNsqNH?=
 =?us-ascii?Q?+1s0UVsoMyuFkfJGeRlQXIIS6zDq6D2+wuqYT+vZVIF70jz3lo/74/nYvXSm?=
 =?us-ascii?Q?9er1RQtB4PdrsyDAUMVbC2ee7I1HdeW7eNbVlBEq21U80iw1PcDIOgq8GUdU?=
 =?us-ascii?Q?yInZoJLBi1/nqKbtAs1FZJsxcMQJP0eWgYz3Vkm4onpSXfJ6uqZUQLIELA71?=
 =?us-ascii?Q?8qhlcdoFMjXFGgNcm0AvLO96JE+draZIfGF3gzBSejT21xWrZmS5yXyZPgZb?=
 =?us-ascii?Q?ZKiMq3+gLVijYHqNbsVoBzD3pepWdapzA8PAsSYg0WlX22qDCkE20w0MfuVa?=
 =?us-ascii?Q?J9se6+oBJ/JklwrS6rO1pw2Rg3FZbuoEZzgOG1NlN7AazofN8CwV3C+Krn7I?=
 =?us-ascii?Q?MgZZVtHeZNuby/A0Oub6VuJRXaNEKk6ktdg6oX5XX11UTDbdAkQEBntgaeqU?=
 =?us-ascii?Q?R4djWwJnl41V9+c9vuwYvHOPdDmQxMhPbymNmUUBBDR59aqzwXuMJFeF6Icm?=
 =?us-ascii?Q?pMJqSz8BT98uSVPLvJI2KfvL6lCVP3PBwZh8XC6dkPJHcozpA+mqkwqiMZ0N?=
 =?us-ascii?Q?lS0Am6QxiuNYWUI7jMHvurk62Gd28mTnmUUMWoY5GWnjovPmHHpHlLADaAYE?=
 =?us-ascii?Q?5NEbMeXZc1E020qmEnaHqZcNHlHFmisGhR32GRO7fa/A7lFidpQ+povKyXbT?=
 =?us-ascii?Q?gyUMoeTHkjYm/KZFeqRPKp5LU10a3m2AwzHGuFjNgjMqgKMVEBUlgTJwERJl?=
 =?us-ascii?Q?vcYfmhponKRhR9xHINNz9xGfxJxKgIkv/Jyn94UdRRNguEHA7ShAvNJfF3qG?=
 =?us-ascii?Q?W4cFrMmOI+/n2ArlDdXIMAxTUTEP2XqSwkQ0OJ/7By4ntgfpwehYJSwgvrOz?=
 =?us-ascii?Q?s7vZVM8Vwkpi+HnZKdgt+zP1a1i/K6Zcn000pcJlnNEzzXnntMXgUBCEXywA?=
 =?us-ascii?Q?hjSaF3iHoGYts+EuHhQfWZmhSYXdqAYU0fk8fFo4ai0hcEmzuxfCXwADsrFs?=
 =?us-ascii?Q?e+sEIq72kLMYK5cy2++PmbSTmRTVgh93iLAXzE2XR+yXqgqypEWZF7Q2mqOz?=
 =?us-ascii?Q?7bl6D8O4DuP+DTtE5o07AUtlYv9FKimSxlX4SONnB1L5wiawugacx5pvJPbj?=
 =?us-ascii?Q?ZLGjOcpzevgt7dY5j8oGyePyNJlX1WW6djbrBaZkEL3Mq2SdD8rg2bZ2OFST?=
 =?us-ascii?Q?dQ0V/xYTV9BxlAF2fnKn4rcL/Ngqq2uuCvTVVwAytn9oxQFvUIlmwHQ/RrP2?=
 =?us-ascii?Q?YF4MDSBbd0eCTRrJxkHMW6Lwqt8hOi61G4Ucq31WUtRSNy2fyR3aL09A6bFB?=
 =?us-ascii?Q?FZGsvmBhgqKfReAcrYa8srexXwdTXUSsCVKyS0jO+esrRdd95cYYvGE6Yyfa?=
 =?us-ascii?Q?7ln/PcF9047u+K3zd20=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6888d02-eff4-4e8b-0004-08dcbc88c4bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:44:38.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FvgPSMr4cxLp3mQCTz/TPcYWWgOBucYjgtwdBIUjJ72Fqx4NGpRWUGsSw2xR3b7j83Vuuih1Z4MAF5Rk+dxAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10606

Convert binding doc tlv320aic31xx.txt to yaml format.
Additional change:
- add i2c node in example.
- replace MICBIAS_OFF with MICBIAS_2_0v in example because MICBIAS_OFF have
been defined in header file.
- add ref to dai-common.yaml.
- add #sound-dai-cells.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a30000/codec@18:
	failed to match any schema with compatible: ['ti,tlv320dac3100']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/sound/ti,tlv320dac3100.yaml      | 127 ++++++++++++++++++
 .../bindings/sound/tlv320aic31xx.txt          |  77 -----------
 2 files changed, 127 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
new file mode 100644
index 0000000000000..85e937e34962d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,tlv320dac3100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments - tlv320aic31xx Codec module
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+
+description: |
+  CODEC output pins:
+    * HPL
+    * HPR
+    * SPL, devices with stereo speaker amp
+    * SPR, devices with stereo speaker amp
+    * SPK, devices with mono speaker amp
+    * MICBIAS
+
+  CODEC input pins:
+    * MIC1LP, devices with ADC
+    * MIC1RP, devices with ADC
+    * MIC1LM, devices with ADC
+    * AIN1, devices without ADC
+    * AIN2, devices without ADC
+
+  The pins can be used in referring sound node's audio-routing property.
+
+properties:
+  compatible:
+    enum:
+      - ti,tlv320aic310x # - Generic TLV320AIC31xx with mono speaker amp
+      - ti,tlv320aic311x # - Generic TLV320AIC31xx with stereo speaker amp
+      - ti,tlv320aic3100 # - TLV320AIC3100 (mono speaker amp, no MiniDSP)
+      - ti,tlv320aic3110 # - TLV320AIC3110 (stereo speaker amp, no MiniDSP)
+      - ti,tlv320aic3120 # - TLV320AIC3120 (mono speaker amp, MiniDSP)
+      - ti,tlv320aic3111 # - TLV320AIC3111 (stereo speaker amp, MiniDSP)
+      - ti,tlv320dac3100 # - TLV320DAC3100 (no ADC, mono speaker amp, no MiniDSP)
+      - ti,tlv320dac3101 # - TLV320DAC3101 (no ADC, stereo speaker amp, no MiniDSP)
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  HPVDD-supply: true
+
+  SPRVDD-supply: true
+
+  SPLVDD-supply: true
+
+  AVDD-supply: true
+
+  IOVDD-supply: true
+
+  DVDD-supply: true
+
+  reset-gpios:
+    description: GPIO specification for the active low RESET input.
+
+  ai31xx-micbias-vg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    enum: [1, 2, 3]
+    description: |
+      MicBias Voltage setting
+        1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
+        2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
+        3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
+
+  ai31xx-ocmv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      output common-mode voltage setting
+        0 - 1.35V,
+        1 - 1.5V,
+        2 - 1.65V,
+        3 - 1.8V
+
+  gpio-reset:
+    description: gpio pin number used for codec reset
+    deprecated: true
+
+
+required:
+  - compatible
+  - reg
+  - HPVDD-supply
+  - SPRVDD-supply
+  - SPLVDD-supply
+  - AVDD-supply
+  - IOVDD-supply
+  - DVDD-supply
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/sound/tlv320aic31xx.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sound@18 {
+            compatible = "ti,tlv320aic311x";
+            reg = <0x18>;
+
+            ai31xx-micbias-vg = <MICBIAS_2_0V>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
+            HPVDD-supply = <&regulator>;
+            SPRVDD-supply = <&regulator>;
+            SPLVDD-supply = <&regulator>;
+            AVDD-supply = <&regulator>;
+            IOVDD-supply = <&regulator>;
+            DVDD-supply = <&regulator>;
+       };
+    };
+
diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
deleted file mode 100644
index bbad98d5b9862..0000000000000
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-Texas Instruments - tlv320aic31xx Codec module
-
-The tlv320aic31xx serial control bus communicates through I2C protocols
-
-Required properties:
-
-- compatible - "string" - One of:
-    "ti,tlv320aic310x" - Generic TLV320AIC31xx with mono speaker amp
-    "ti,tlv320aic311x" - Generic TLV320AIC31xx with stereo speaker amp
-    "ti,tlv320aic3100" - TLV320AIC3100 (mono speaker amp, no MiniDSP)
-    "ti,tlv320aic3110" - TLV320AIC3110 (stereo speaker amp, no MiniDSP)
-    "ti,tlv320aic3120" - TLV320AIC3120 (mono speaker amp, MiniDSP)
-    "ti,tlv320aic3111" - TLV320AIC3111 (stereo speaker amp, MiniDSP)
-    "ti,tlv320dac3100" - TLV320DAC3100 (no ADC, mono speaker amp, no MiniDSP)
-    "ti,tlv320dac3101" - TLV320DAC3101 (no ADC, stereo speaker amp, no MiniDSP)
-
-- reg - <int> -  I2C slave address
-- HPVDD-supply, SPRVDD-supply, SPLVDD-supply, AVDD-supply, IOVDD-supply,
-  DVDD-supply : power supplies for the device as covered in
-  Documentation/devicetree/bindings/regulator/regulator.txt
-
-
-Optional properties:
-
-- reset-gpios - GPIO specification for the active low RESET input.
-- ai31xx-micbias-vg - MicBias Voltage setting
-        1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
-        2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
-        3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
-	If this node is not mentioned or if the value is unknown, then
-	micbias	is set to 2.0V.
-- ai31xx-ocmv - output common-mode voltage setting
-        0 - 1.35V,
-        1 - 1.5V,
-        2 - 1.65V,
-        3 - 1.8V
-
-Deprecated properties:
-
-- gpio-reset - gpio pin number used for codec reset
-
-CODEC output pins:
-  * HPL
-  * HPR
-  * SPL, devices with stereo speaker amp
-  * SPR, devices with stereo speaker amp
-  * SPK, devices with mono speaker amp
-  * MICBIAS
-
-CODEC input pins:
-  * MIC1LP, devices with ADC
-  * MIC1RP, devices with ADC
-  * MIC1LM, devices with ADC
-  * AIN1, devices without ADC
-  * AIN2, devices without ADC
-
-The pins can be used in referring sound node's audio-routing property.
-
-Example:
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/sound/tlv320aic31xx.h>
-
-tlv320aic31xx: tlv320aic31xx@18 {
-	compatible = "ti,tlv320aic311x";
-	reg = <0x18>;
-
-	ai31xx-micbias-vg = <MICBIAS_OFF>;
-
-	reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
-
-	HPVDD-supply = <&regulator>;
-	SPRVDD-supply = <&regulator>;
-	SPLVDD-supply = <&regulator>;
-	AVDD-supply = <&regulator>;
-	IOVDD-supply = <&regulator>;
-	DVDD-supply = <&regulator>;
-};
-- 
2.34.1


