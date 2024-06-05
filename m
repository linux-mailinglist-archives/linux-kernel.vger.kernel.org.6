Return-Path: <linux-kernel+bounces-202129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F38FC817
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663F71C21BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE3191484;
	Wed,  5 Jun 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cpScVUw9"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7318FC90;
	Wed,  5 Jun 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580361; cv=fail; b=IxG3IJvtqZu3bJf7OTCpeFqahZ967YjzvMvZxD0heaVwvEhiFdbpqsmeE7tM+2Qjg11RGtZpY1CparR1Ti86f3J0rImD7P8eeGK5+5fjyRF8xftlly4gvXgdLEYyydz1qjm0a8wg5ylPyAcGAYFrK6dxmI9L0PdM7x1MdoymR84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580361; c=relaxed/simple;
	bh=EtIw3h4ZZyPpZDiH0/3CWgnc1cHnWfhfAahYNl5mDqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjYvuQaPQSi7Ylfmc2F0sw60OoBlVT9/Nh7JHLBpAkRw/C5lkjCibq/0GbdVqIQ3ALR4+EVyP+Hk/3llJ64r/AZ2Ijbj7DNmaXQbO3TRswY7GCu+/3F9LduDRNeMDh85/SqbWhAt0TsQy8+usd3aPBm7qChe9KlM6wN/4hYBlUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cpScVUw9; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELSCJk8xZcN+VqjH0F656DFikjoxbiXne+U0/LstmktEUpZkGn6FZA2vYvyQiFVQLWu52zzddRogLasdnCddM4O2mhdHj3V32teuI+ag4C4syx744HzW3LxKXxFIq9jeSJ8t8Wihkf6SdebM9xL+2wSoKlXQaBNVKFfTbHUfrriP6LjQw3yLXYJIznUGFnJDUuPw0NH872N9eY9guVbi9/v002kFpHqBxoqQACIjZMe303G+QPFwef/9XWOJ1MEykN9YakwqrkwjUqtLncDYH0rMdYokNX/gy3shmvKnJMm8GwAPv6Me/PLaRru6R1hgRGZJDRLgiNyc/bhkYuVM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6M8RZS99F58O8Qjt359FmnO9h+LcStA+xZAD97hZkk=;
 b=IplpEXugKk+FqMh/ULt6Wu8431+3K1x+0LEj6hTpITolc1Pa3sMhdl/eExSqEcSGVvTOi/B9eNWhXY3J89nr6RsBdrCht+cyw96xlIr0TiUjEkVmgyPQTq7R595ofeog54iTzEREfnpYAhp+TI7zs9a/F8QzGPxGK3hJbNSlLoeVT/DPow1JVfiDYYTaGjmpI4oDpmCc+GgJw6haoDlD1VJ7gSG1UX7KRr02EG9s/AS43TWqnGGsvobRHE/tRMJsxQA7Epuhz5VxchuGgZzQuYkwhZHPGDn1u6ctZHUdEhrfdFoHOrejC5eCgGLe9ZrCAMOpVGrmGRJkNypBEhSBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6M8RZS99F58O8Qjt359FmnO9h+LcStA+xZAD97hZkk=;
 b=cpScVUw9guxNG+iUBXRZY/Oy7a4MfCnHQz08cdANWl6EtglgeukmPJqqCQ1WRtg8vG28RlBxLhjktkXJoqqYd8cahPVaiOOcqIguWmnIe4Iw77KektmB0kpXCkLWlw6SKApSKZsQHdCtaVx/UWiPvXX5TOrVlaPjAFI9HRMuUts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10519.eurprd04.prod.outlook.com (2603:10a6:150:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 09:39:16 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Wed, 5 Jun 2024
 09:39:16 +0000
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
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
Date: Wed,  5 Jun 2024 17:48:12 +0800
Message-Id: <20240605094812.1074027-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240605094812.1074027-1-peng.fan@oss.nxp.com>
References: <20240605094812.1074027-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|GVXPR04MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaaae80-bb49-407a-d40e-08dc85435dc0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|376005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hK5pKbdJBouNegK+7qIPRJA3ayPpbe+GsJ9RP554vzhFP5t7jpcY7uprG9XA?=
 =?us-ascii?Q?Zq98mSz1VM1wOfdr3E8PhksurpopSs7iWlqgsKbIsv0cDBXskyuufuXHwUNi?=
 =?us-ascii?Q?tXvlwZMGtKDj+JDv3UgIayDjNRz+IMZk76W05YqY8rzV8f4lmhT2UCOxtg7c?=
 =?us-ascii?Q?kQLt4/GPvez2hk2DkWHW6yUfTA7LRzqkjRT+tJZSC27NAY9VuHxN2mOW9v1x?=
 =?us-ascii?Q?abC3IMf+VL7X1fr+C3630UcYdtEmX9PSVU6GWxNeeLJvgiKZi0X6J0lzOZie?=
 =?us-ascii?Q?dfNzezq4v3eWpaClAVfiGzQanVCH7JbluA7UwK3dc7gUdPCs9H+FtsYrr05e?=
 =?us-ascii?Q?2UwG9Ax0Up+aYDZoKFFdOMSIufO1l8vHs8zU2+YTSIuPtUSpoIDeJDU7kIv6?=
 =?us-ascii?Q?ALah5RnuA/qZLtB3poMUvleXv4APeRHn+cCfpPY/QKNU+jowtVlZ5XW1Jjy6?=
 =?us-ascii?Q?J+SiObjRIeJ1NhNk8nCfV18j1UazFjKnsDTQh0BxlWnOteW+maar6G3/duRx?=
 =?us-ascii?Q?Ksw81+eVohTaCLGTSpSprGF881PwAtU9SQ/Zonm00E5h7sn8iJKKLDlwve8B?=
 =?us-ascii?Q?BWDMo7fiwn3yABp9NI1XvBF25eXIhWzMSzBHCHDshu/cX6MWymVzlAIiurMR?=
 =?us-ascii?Q?lhr8oeuf6FiOEKLrq7AvYcdgglhSTNgIslKIhDDnpYFdTg/DD/MJoy2Qftqx?=
 =?us-ascii?Q?GF7BJFsyPHK5YsdgAFsl1Mshkt0XqS/oOGsdgWlrmri87VtM6HD3JRQA27FI?=
 =?us-ascii?Q?4h8UHYS0/F2sWLfTQm2bvFcV9svP5nnCoOY8wxiKyOSRT0jgNe/nX58s+TsA?=
 =?us-ascii?Q?f4Qb1R9BPujAiNOVYtGT3jytyZGpWFLppWVRJoxRsAPgPCYEHzc6BNNABMwc?=
 =?us-ascii?Q?Tmy59YtiRF5ahAAHbrx5tm07/qdD/Q+LHPoGsDagGOYynB+mxHs0ThWojRHW?=
 =?us-ascii?Q?Xx/apL/95iGKCK7JTUT8C9mYa0scp/gV5VCC8l8MbGgc5+retrNm/hOQVTgA?=
 =?us-ascii?Q?iP/N6c/q0lp62CIG5kil6foAsns3T4RqTwcs90hsc1W52jhfv11x02yHmaDV?=
 =?us-ascii?Q?+iMg1EXJYYB84dDayiqYp0IlTBfD8sude8C8ZccX18lIR4CxsT9M8KUxhKX9?=
 =?us-ascii?Q?CWCKa7M9X+JwXl8n5Dm/B8743H1GMkIrZxWy/VGLSwIXOWHt0KS7Y/fR24na?=
 =?us-ascii?Q?mKP/Z8hs85vbdMku+8WDTE9eN8ltvJziQZaug0r9teix0FtApv1t0mvQLPyQ?=
 =?us-ascii?Q?peNZ9F8v1jTFlHXscVeIuf1gls5FwNgeakWrUjM2lzDH0D5A1P7YBXor1Sxh?=
 =?us-ascii?Q?3XlTO4zMKnHjt5gCD07Evlb5n4r1TXEv3eRlPZQ/uiLr2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3s/jz0DMw/bgTZ88Lt77ua6l5s8Mzg+avFSz6w6b7/06YUuPBJITqQWSIh+?=
 =?us-ascii?Q?MTIeQlM9kAF/q21+7u5/XgW4h5goKtBuUn/z68oGpTUyHdI9nbfYgMBTNF6e?=
 =?us-ascii?Q?vVoYgcjcpNTgQ/UfqsWpx3YIDqgTZbY1pWcilA4ZGizsABK5JZewi/wWotUh?=
 =?us-ascii?Q?TPLFsOkDcMsaLq7wBjasKSEI8QRTTm/eAH3y+z4g0g7iniKdvwnjdvnVJMi4?=
 =?us-ascii?Q?Q90PTxwwqIRqhf0wnyUteTnpqUONoXMmnUgntPz395DpZp8xREi/+bHAosO9?=
 =?us-ascii?Q?N0aMe8xpelXQXmyrlRj+qd7kHX8FSeVqkHdtAc65L9sy8/KvZjnr1ACEXShX?=
 =?us-ascii?Q?PJRY4XhgCAXxam11wP3B/x3VRtaU3MHIDH8lbXmifkbUwge0sNIFKxYoka44?=
 =?us-ascii?Q?H8LY2+lIfyILYIxuGl04rrVAtR+T4WZiD21CAWScK7rrNvnatPK84e1HHOWH?=
 =?us-ascii?Q?sCLf4xHKjzQl6UbOftJpnKeseytCmo4EHMfuDle1wjdCyP8Ihx+RU3blz2cP?=
 =?us-ascii?Q?mS5EZW65vq0PEjLso+r0Ug+dem2TLSQ9q4V8AAvR5Tpj8qph9XkCitvZBAvg?=
 =?us-ascii?Q?WfXChH+HY3iR0wuoj6Hi8AZ9MQ3nEnc+cmAc8LcPvU14AXxphCNy2SN7fUHA?=
 =?us-ascii?Q?7Q6nONp/kGmKgA1t3XKguIsBrb/Sd2tAQNYZ4d6f7lq0Utq4X4GIHytzM3XX?=
 =?us-ascii?Q?woKvGzV6w8tFIhOOPwuCLgNDn6A2czNk83NCxksSJDwQdzPYVPddIu5OwTqH?=
 =?us-ascii?Q?rIBtrGBfp/XVCA+r54bTrTwzKWjuV4x6U8vf79FPPV2P3HumWA1ePz/uCte+?=
 =?us-ascii?Q?tEGMNyPjUiVAjqYvkXEC+DyFzGWwmVx/wNELcpCoPpLhCcoJXvOmM/KAnfqd?=
 =?us-ascii?Q?mWB9mYBPGSDFJd+DYMMNfKsCKonr+FEfmoNRrGtrd1JO4oYNKUnpihsdD7Ag?=
 =?us-ascii?Q?pZhFrLxf5nnNH5y7SCBmoMnRNY5uBqUyhq2Dnvdp461kyKZoGr8bPXtKz7Cg?=
 =?us-ascii?Q?s6YpiuogUBdc/LhLVIIH2uokH/toRhkyaFGiPTFftfpRFnrNOEU/p6J7ktbL?=
 =?us-ascii?Q?zJKFXHG6RiPACIfN2jYCrUYSwGbKAU8HwcNNn2yS5kTu1hAvDY5NBTCnpqrK?=
 =?us-ascii?Q?tmzoinh01/+fZ9SkhM5Bug+WouoRUmxMXFMMmXN9i+pz7T642e2e+n10m+Hx?=
 =?us-ascii?Q?CS1YCyiT3FnHHeBQOVuR01XwtwyZ+yHS3mhEyJplOPdPK+nvlrXkuqclAfDL?=
 =?us-ascii?Q?FWYUmTUEE/cejCCJWqNP/naSRd62naR6yndN7I0kryWZiBGuLlXqh47qSfEq?=
 =?us-ascii?Q?TNF7NWzijNXqYpP7gzgH9JMTLi2z62tmDxMl/u6wnFAFewp/6g1rczs68kbq?=
 =?us-ascii?Q?BwrkAWGONKiDHVy9f2vAI7kLYnUmWmVIaS8S91REfrbYEsq083bguF2coCVb?=
 =?us-ascii?Q?PhaMPmXykDRWTQ7hPCbtVvygZYfRqmhHk0vKoiQGGkhMbYEzYI7Nysz9Bz9/?=
 =?us-ascii?Q?FKbiOD6cw9+qUShCgsAGJPyCPDQEIDdMbkMCOn6coAXMpLqfP57SL7misbB6?=
 =?us-ascii?Q?c+8NnW1/AxsLvVy9cWosQCnMKJhu9+f3+W2l24Mm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaaae80-bb49-407a-d40e-08dc85435dc0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:39:16.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFa8djvOl0nngnnY2k/lc57zQZGMjHUH7qoXrRVUM2P4VBPNTeWa41DL4T6htXOqtt1HKhttnx1PWQtNKbDM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10519

From: Peng Fan <peng.fan@nxp.com>

Add the board device tree with sdhc1/2, cm33, mu, lpuart1, lpi2c1/2,
usb enabled and etc, which to support the i.MX 93 quick start evaluation
kit that provides a low-cost platform to evaluate the i.MX 93 applications
processors in a 9x9mm package.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 505 ++++++++++++++++++
 2 files changed, 506 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 1b1e4db02071..2f7c5ca4ecf2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
new file mode 100644
index 000000000000..104432ab8fe1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
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
+	model = "NXP i.MX93 9x9 Quick Start Board";
+	compatible = "fsl,imx93-9x9-qsb", "fsl,imx93";
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
+
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "VREF_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_rpi_3v3: regulator-rpi {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_RPI_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 21 GPIO_ACTIVE_HIGH>;
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
+		off-on-delay-us = <12000>;
+		enable-active-high;
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
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		status = "okay";
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
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
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
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
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
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


