Return-Path: <linux-kernel+bounces-348271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9445D98E4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C2D28169C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC398217339;
	Wed,  2 Oct 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hL3cH/ex"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904E745F4;
	Wed,  2 Oct 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904394; cv=fail; b=j4EkHp0DwPuWZkUDJy4JBNG1TIIvJf34Z6xDrJXB21ioNRFD4GLZM5iWlBVNMIVRtBo7hUheTSAl/2wN64G64jVsHd2GhNnXtYFv5UUrSkLXUOwUIwlMyaVzhFYzxWzlg0EOpSF/LRgl777usbj2l65RHoFA6Vqv/lbPJSlfRO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904394; c=relaxed/simple;
	bh=RrFhughtGHGhcu0r7vmzm8k5q/S7ogYk4JWHVrzciQA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AY+mNHHL+LhNi6hG5f/IRILnZVrYn9aTYEGMRWgmJDV90stTfd3mmER0CAPxJ1E6C7TPPPiL4Wf9cXxyub73DB9bKiOmQwMN5OOt+n2modsnGWRc/VX/ginjp+SREJGi5QYDLVxx90bGj4q8+ElHDG8dqOI7umpoHd7JBCeYbKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hL3cH/ex; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoU+bGHBYsqiqNLldgXXybnrjLoOap0J14YLNRFTOLYHaclCVXG5WDVAyM8FP7FFbWxftWCxoArM/lH0tDWk92yhGCqimKrMvfmN04kv+L/1GgdDlxBXhZalfgx5AQ5cwSOkLb4rFU7xyxKd27efLF6FFeTn11J7IjtsTzrxqwaiy9DODMLkhcCRlbIj4jete3V514hmlmgqW8/Me2MdulZwllKk1K25LM0bjz1VVRiSt0CjoDz+N+bRMaXNq9FBexHV/POphKwuQQdXMBW4wnrjdW1LT+d8xrk7XQCvyTLGINhI1UjHAualSzjaXqF9JMzlTN+lMvjudx3WY9pj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhV7H1pH/H1+RPhV3jA5HqGwqr94OUQqieIx8k8ZDMg=;
 b=R8Frb9/Aq6sB8/0fqpP/6sptNot5C3O9JRLhqrs+gCAahzYtBiSUkj2orG45cYcHALblYd0ZaaacAqpdFvhK9wK9lFBF2V0dlJjgYhsUx+O8xMjS9cpdLCk9UwFduR6aNcP970HFyXnK0xqgfdnseiMWEChnUIYFgkaqMbVbFR87+zlpLYrUITjT/y8j0PLb5JDtc7D70h80yh2JcFclHkCsUSYGny37394wG6quUHcy3uW62xf1ZzKurmhtt9+Ix+Th52zZD+3eKqHmfcg3IdxzQIhdos2VSiijYo9E19xJ9iDyLo0AxD9J/BiVS0HVgsn/QbxV9eOmxT1WchtR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhV7H1pH/H1+RPhV3jA5HqGwqr94OUQqieIx8k8ZDMg=;
 b=hL3cH/exwdVEyFuRdPfdJZKtBm/WpN3HccVwkaTkdzChipgOM74QLYK6xRXVkppSwqheBjI/WrXI5GA3YrDO5aYTcevSy1KTalCUg/0SX2qB7MTbHwb+IcqudWyJigs0oAgqNIrddtpUhkNJHXV8l8z5wY5jEalUk3+X7g/i02nH/W0Ml3weDQZztVK3AW/EhhOlb7rJPdiMgFecL+RQT72YSBKfrggQwuB1NsG+HxCH4l/OCAmsIfD4hGpCPu1D+oXHWVGwW+wvPKTVbRyAfH1Jjc5rocJOT4EGaCRGMwYzXNaz4c0dZGBIhO1PsrAEKMZ6scsbhFYfNkfOkGxaXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 21:26:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 21:26:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq: workaround wrong interrupt-map number
Date: Wed,  2 Oct 2024 17:26:13 -0400
Message-Id: <20241002212613.599687-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 251a7e3f-fa16-4685-9d85-08dce328e046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EWoNlgRM0SBh4QKp7ZotyFLbT0LO4pumnkw5/cV88SKwoTXfaQ5WtQGfeqta?=
 =?us-ascii?Q?EUhGvJhe5AscExL3XsMzTSnHj9VWTVUSyjpbAuZuioZwfTDIdnSpcIgtCgPK?=
 =?us-ascii?Q?gUxna+VHQ/aoJjg9OTz9TJKN9WE28U1SRaaOFu213FH5RIAsf8U8RKYXa1+t?=
 =?us-ascii?Q?VaJVzPCzIkla+E5HU6UQ5dq8wVQglrSXb5X1OKYmsqwct4bi3eHdHG9qQZYw?=
 =?us-ascii?Q?YCBR3SO873p21jBMgLOjciAgndHomCSoJSl8CYxM5rpmkEsgg8j2O62enOfN?=
 =?us-ascii?Q?CuG8tWXrmHsEcp4HbC6quHF14lhlhqu6hfRaAcZ4T/OkkaA/KVKD7ensbA3+?=
 =?us-ascii?Q?n0OZhyNGHeMdtuNyuhIvhr9G2dcG9Urct1TvgXujkyyXAYjXxwu1dEOkPdCx?=
 =?us-ascii?Q?ybnAKgBpaJyayn4IkH6h1/VnWQQ/Ok33eDokAGaMZ4WK8QiD/5uLz3FBH9w2?=
 =?us-ascii?Q?dE6G+13c68HSKibHnr8hkvszdc3wP3VGqSPPXhjh9Al/Ahx8PaeJ6QWboTAv?=
 =?us-ascii?Q?BSurQpj1C5UahZBvDVSu5O+EpABKIp393ig8gD0sGQ+NvB+YrIxbO5p5S796?=
 =?us-ascii?Q?BFis+/XOMu9ud36AkVJM5vahbWZgZofYeS8n0Z+pKTbpxpbKi1eRQXjGtVRJ?=
 =?us-ascii?Q?fIj67IVAMaLdPeX4uVTOQXx3OdfQnu6gKOae/mBLwfiQuYS2ak7oYJ2InZYw?=
 =?us-ascii?Q?1OrPSlhYu8+zhgaleOlOtkBO/dkB9CekMVq99YKH94WzsKSEbmxkYqzQAgeE?=
 =?us-ascii?Q?A+aHuHhDyvfwSz3/a83qJKQrN07JWH98Dqc8nw60I+k9V7RwZx2XDmaJFq80?=
 =?us-ascii?Q?Cx/DJiw+fh83N/cg+vtaWbYU+OUCgBE+rFImDOll98fYrZdFv0pNrhwTJ9on?=
 =?us-ascii?Q?wW59k/weLbgm+gxXc7x73XooqjwhRNRhTQwH93tYxH/cSXG4G6FAyosDxd+J?=
 =?us-ascii?Q?B4W3cqipim6/9ResdcPq//w+T9EpWemVzWNDvkVcpN0Nj8/8MsjNr6FO+Qr8?=
 =?us-ascii?Q?XpKicCh63z0YlcK+TgaNoFfAzt3Cwvl4i0BP0Qugx92GSnnnvVq6OuTli+xk?=
 =?us-ascii?Q?b8CGYUZn3TJvSD+7pAXMcmWB/SAYNp4bHc0MnyS3tZErd0vRTScRAWvVytJw?=
 =?us-ascii?Q?FIvNJWQPuFFg3AlBVeI5A8CF0CtABfUyqPai26yRuB1MJVjUgkwD5+tzNMzk?=
 =?us-ascii?Q?Ge1GCT5wGexM1fXat0+XpVY/BgphxOZigQq/kBYS2cbDNkL7DS4JV4S8v7jn?=
 =?us-ascii?Q?CDcqBhKA9qIfHQyNip/CuJhePghwYiXTZOxZqbbtjGRp1GkTRXrFJwm5LTvg?=
 =?us-ascii?Q?y/loiYFeGK43xxQot0/lbcFweVgbdgpW4LaAQ189UESvJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mrmrHeSLOwpCyhMe9qQWyhpxxW6A03fb21ATJhSKl+Tzbp+yM2juTWBcC5r?=
 =?us-ascii?Q?PWv5ipMamg6vC5PMNv4ZmnYoL9K4Xh6cO3XT1kOrZrjj2VpkvxAKPzlRv9bm?=
 =?us-ascii?Q?v0HykpcGl34VKVwTmPyq6X9Hv7S9CDDrV5jmc1RpqnBPjW11CrpmIWIVEKze?=
 =?us-ascii?Q?ab5qlDgLgHZMVNg5791OTeRsVjJiRKPPwA9CrvstLeKlE1w3JNY22k+Ft/ud?=
 =?us-ascii?Q?pvzKLxTx1Z4fRghqbptSD3PIu5AxEqyQWjosO4lWi1Xxsn0CyW/XJDj+RqUI?=
 =?us-ascii?Q?42hnMr1PXrzP3/0EkV7MHuXC5IAFDUnjuMqkESWsJehGMBDBZ8cdWkRVoIQa?=
 =?us-ascii?Q?Td7nn3GxT7QiZ7pFaOvh2kjkPFmWhXet36QPAwJ8Rv5OnI0qXuGIPnyDTXqj?=
 =?us-ascii?Q?tmEdxVP6A5e3uYduNzRgfIddCmQGyLZU5ZcZqF6/SYn4ppjBYykHhuO4I6rS?=
 =?us-ascii?Q?5YC2i63Zqep5mqmRZt+Fc34i0O1Tf8Kbh9G4W2SFBEtUQedVYOwCuxCBL273?=
 =?us-ascii?Q?u+nJ/+iVK3qZJ86rkBM/Dlc08wkLkGKhQfGbYSPe8KGEyvFNhGx+JVNkej77?=
 =?us-ascii?Q?hJClTuHJ7VHjUWbLE9S+7cE0F0mYBQ4lITfL54O9Pu5Ns1r6zV3wJpo2RR+S?=
 =?us-ascii?Q?Nz6MHaVy97y8iS+pb2Lq81C1clXjPqNLL7Ul6HLIPU/S9M3jZ4E5SIr2txy0?=
 =?us-ascii?Q?7k99TXs83p9/c6sjcP6evKuwoORkBc5T15nwnMfoQBAr78MxAsySob+lRtjd?=
 =?us-ascii?Q?BM9Cgtgl3/U4PjvDFOzUmJmPtKp7rlsXdsgFLRdbaRvNHAaeVj4RCdtxi2nV?=
 =?us-ascii?Q?EF66Cu/ikhUo+BEQYH3Mum0AAc3WE8sHcvTzT2IQ40b6Rd6gYLq1xKa5N4TB?=
 =?us-ascii?Q?t9nAUdAhW/rQa2zGnSej1uAVKo5HaSn/KaUoZibcjtmwQYTWGYpd5Y7Ooc5J?=
 =?us-ascii?Q?G6X5P5y60RKxK4+zfuHD2E4tCcL5QePE2Rf3CocO2b0+G4+b1BWUCa1kG0zG?=
 =?us-ascii?Q?Aj1ztVtBvmu3Fg34ScLl5m5uyMEGVK5KRBEEMd/GxyJREIROp5E6l3B2T+OW?=
 =?us-ascii?Q?kno52oewlnjcE1W1n/6nKgcMs/mYBr/sV9d62NE4cvGP8ua+qRfichDC2KT3?=
 =?us-ascii?Q?tR+Uw1Qx71XODY4VJbc7YJCAAgDlTK3lV9r42seNzl4F67m2kezgwdYvm/sy?=
 =?us-ascii?Q?587lOTNMZKARsxlNnpJeGUQUGPT8IVnH+gDOjLK9wO0eH9SkdN2FSb7sDM/Y?=
 =?us-ascii?Q?/8/4K7RFUGMb2FmvK6f1IM8ElTmivrmrD0MyB4FhFCZlR/1qjw9UlooVL0Nr?=
 =?us-ascii?Q?JvGmPu7FGFvT8q/Wt6RPIIdwsJtYtuvOcy8Oc0W+aHOceaQqFA7x2EdGLWeN?=
 =?us-ascii?Q?uQLmCtb2c46oLAXin+WJknU7KAU147yJQxTuPSaiewZiQVa0uWim2OlD4KGI?=
 =?us-ascii?Q?HA7sFh8MddrpzzjnvHXyqaJaW6R1wgGV9caYjoKNDtEH81RlDN62tRy7ufmT?=
 =?us-ascii?Q?h3ZcbMse94CCCnpBPtpTaHbt6CS5uN5s8nPvDtiQgqg8XhEkQWD8n1Urwigm?=
 =?us-ascii?Q?USfWY4fOWcGflPBwEEU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a7e3f-fa16-4685-9d85-08dce328e046
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:26:28.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBCACIlwTZghXTx6ktaSUX2amCBqN6MayoQFZ781o/dmzmmazSLo/QRosT9AK/CN/dysbZvxOxCeudjhCc7ADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260

The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
function function to parser interrupt-map. So it doesn't consider
'#address-size' in parent interrupt controller, such as GIC.

When dt-binding verify interrupt-map, item data matrix is spitted at
incorrect position. So cause below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
is too short

Reduce minItems to workaround this warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/interrupt-controller/fsl,ls-extirq.yaml     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
index 199b34fdbefc4..b52abfd3e19d4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -85,10 +85,17 @@ allOf:
               - fsl,ls1088a-extirq
               - fsl,ls2080a-extirq
               - fsl,lx2160a-extirq
+# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
+# function function to parser interrupt-map. So it doesn't consider
+# '#address-size' in parent interrupt controller, such as GIC.
+#
+# When  dt-binding verify interrupt-map, item data matrix is spitted at
+# incorrect position. Reduce minItems to workaround this problem.
+
     then:
       properties:
         interrupt-map:
-          minItems: 12
+          minItems: 8
           maxItems: 12
         interrupt-map-mask:
           items:
-- 
2.34.1


