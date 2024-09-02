Return-Path: <linux-kernel+bounces-310662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E9967FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70351C21932
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305515D5D9;
	Mon,  2 Sep 2024 06:57:19 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2127.outbound.protection.outlook.com [40.107.239.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D6136982;
	Mon,  2 Sep 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260238; cv=fail; b=Hj6ybkA5B0A5YjhOvJ6nbhs/7q1P5T78aQ02dqp2AhFwlTgm0xH8fHMGuqKUmcigJVZcRZjF63+x4lXR78Z2hkLzFDLYU3pYngLVPjeFQG42eEg8rZaBMnh/gP3n173csmaKCvOqD0/nh8mzvxAsktpItoysH9MeweZ+42B9byQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260238; c=relaxed/simple;
	bh=Jlo5sj9XvSP71OE9pJ7yLMtTXRNEUfvDH6mRN/iaJFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLEgIUzeCSZP7J9li1jJFxXFWeRrcUbQ8ksMlafdh7tfWWIdqpzAn05+SgBJW6QU0f1DmEE9IrRrvOXXO17WEAYjSeTYHRJr27iX6Yiur0KwtG7EprG1kHjqt0ncJOgQ+MjbtkM9vXpEbTR9kk/i11qP0RccAKJOayyH9nSAuuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqr2fHVVdM24p7rtVkoPvU9XB70dPvDgE1vpnTub/e6A/VP2ikFc1G/XLQ0TleTj0hxWh1E0/cNz0kkR5APoj3hYKqeERkR4HqUNcxZScRDr/6UM8nJ3WAJ7ONuxRBOPdaiaWh6RNVDsP4NNnxr2hBFWcMFGnHJbhi16Bg8l4btg9y3zKijDKs2MyzPH3ri03sNkVY9ws+58KfWLo8veaJ+4EFO9AJxkDeBiqz6rg+Lqm4XQi3YNLG1YTr3Kz1Wg3sgrVaJZvULhawebnNsHs32Ja5jOWzriOkSkGqrHNvMgYgig69RuojmBvE/ovZnbnmK7w7LgrylGzoPKB+28og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FaeWaHOt896Uq+w0K2ndVjtpNk4KmXXUTHa4e2gl3M=;
 b=AX4PJPG3uQl/aeTUvKkJ5OFBOmRRJZYf54jwquhRx1ho4Fs3lPfp8ShPeljfF9RAMBUh5kgNg2XIX1CgH9W0bPRvMyIiJc+BjAn5Uj3W1Rcan8t3ywJiUS/wsZ/+B4xVbjYp9ZL6R81SMwvGHka3iu4mV9oN0o6HRT/VAitOrodm2gVdovgAxhxOMcC7n6mae5uIyh4Ivp80zbEJrDQEuI6RvX6hZ2KDeHq41aMnlzs5/7Dg6MdBNaey7QuWBHZRD2YNmoi00uBDopZ/q9zrlBc7dvc5xRj8pDLO9f2g7R4IINFkuTKyoRYD7aaNDSNFDT/qFs3nOtC+XhUacUrRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAYP287MB3612.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:57:12 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:57:12 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 12:26:02 +0530
Message-Id: <20240902065606.8072-2-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
References: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|MAYP287MB3612:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b74a5fe-2805-4f53-68f6-08dccb1c78e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gvJOOlH0Nj9+D849qP4G7AfM/SykXv0He/drzrK6xo2xaIMdGM5NQWzVS0a?=
 =?us-ascii?Q?XaB/HzMviAkDgBHdappp7Pj8jBUBh8csCrg4aS/Mhb5mMRyz0Y0aYyHdNK0h?=
 =?us-ascii?Q?7eJdv4mjhV6mqJ7N0tGnm51PEKfgCqbUFXIaGW3T6CC/vn7UXtl6ivPLcsPY?=
 =?us-ascii?Q?0ixTejONarBGnvCT7cQ3WW8BTIDOGo3q5cmmyLrt0r4rZ5fHjWxr3buna1kb?=
 =?us-ascii?Q?Ku0+lJ7aFSHpwytYLl2PeBjm6cdcZh+V6CtHWkRMH2hqkZ4gjZEaHyxu2dCi?=
 =?us-ascii?Q?4Ecv+nwVaYJDhWB2yCli8eeWyappVHn7rlB68/v6K3lHMijcSaEon9eQWI0V?=
 =?us-ascii?Q?agcx4ZSUVzKAslRWDjAph9IvWe7MuPNJ9Wk5Bo7X0rt7dl9+OlQTQfMXmdre?=
 =?us-ascii?Q?0USC83Epn9meP60yJb2e19ud1OfU2vk84uE3G3pR4tGpFESy1Bin1d4MvzzX?=
 =?us-ascii?Q?+XkFheF2zkkv7HUE01sI/ZNskz/k14NoBUg8VgCSZOar53YxaSEHS2MMbbzF?=
 =?us-ascii?Q?CD3dvAGPLCsxkdavYtQ+hIoeVHqoWsmhRX3i9kLJVosXkCtGEZ/AK43qIdMp?=
 =?us-ascii?Q?2KeSk+7AvBZB9IM3of1C+GqiXS0gY5mDIUPvFoLkfL8LqP1MzewTOQXxqpCp?=
 =?us-ascii?Q?8vGL1s7Kf41vicwuFkeRZzuD49y4GxbwEhGM2fvgIDWM5gE0Y/tYRptmCewc?=
 =?us-ascii?Q?/qOz7PiwrgtD53Yl+i6R1gNLE0K9WjOG7E2AE9lsuCL+Vw3Adzxh+0T72kle?=
 =?us-ascii?Q?d9I2B5oIBpLSnLS2Xt0GPbItMq4ClTmD9mw72YzJrE/XxvUFDYjBgNNaGagR?=
 =?us-ascii?Q?z0EDQG3ZitEwnATfFceFkLONGV3yTkTxyqljuyKifDvMJu8TSoi4OXU4+5vy?=
 =?us-ascii?Q?Txkgk9FG9SaZjzv0Rckn1aaIJdxwBgvtZ1f/JarZqeNDu4Qrs1qA1S+Cn6pz?=
 =?us-ascii?Q?Di5FjEBwe+XNLpVeu+SaPZ7NpaveW9MrzdBYlD9FtRht/tUvRaKSb9oh5EJw?=
 =?us-ascii?Q?lPit6ekhFbOV4Cqsdpt+C4N4B5neL51w+Prcs1owtr8fVMT3H/MLMuQGSzDy?=
 =?us-ascii?Q?Ccc60WXJgkrhBIXqE1oVY/E4wdiCt5iAXy/LaKzpopID11R6kcdMayqjNBW8?=
 =?us-ascii?Q?82EHxt8U2E0wjJy8dGwgU8TOqKK4AcfAq42PcALsA9YGKsu7b/N8tcmfM3QC?=
 =?us-ascii?Q?GwLABK3ibiczSgx6ZQMXhhsvHJtPZo8hcBFEv8W54A4BTDlGQKOfLrQLRSNV?=
 =?us-ascii?Q?8aS3zwALBwmKsfHMaorda8wkS+YoJkTDkIbogfUy6bppdDF0KNq2NxcDshgb?=
 =?us-ascii?Q?tOcD4NqGyJ3Gwm5XFk5CXxVrt3yC7Ly0MtXjsqtUxMaTgjk7S41Fw+Ba88sd?=
 =?us-ascii?Q?qxDk8WZs4Iosvqo/zyEB7mln07O+Ow3nEoICYsDL9nip8/k3nQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?agpZb5+xr0dC4+d0H9XUBHDZgOh3f0r+Q6DFzaiLlOUQFkwfsR5P0j/xqXWw?=
 =?us-ascii?Q?xi1nuIXfCP0tJBfBp8UxGuxm2p0Ij+ta9mRERgu3S1QizPSiMmndXZ9QAa+1?=
 =?us-ascii?Q?lb0gRneL2SfRm1/ltVMfJ8KJDbTELGmhN2j8ZD81Y7TY3kZUJOv2c7CIx2T+?=
 =?us-ascii?Q?LfUWhj9nie1wzy4si/vZSK+IfSBRvtTiQcbTSjxJRIxFOa7fRCh052/3FwhO?=
 =?us-ascii?Q?/lvP8v8y4FnTwxCnTJPJdOonGcd+ngmeCYdkpQmBQokovpTyVCLX2CjZZjhp?=
 =?us-ascii?Q?kgtZxGMbVJMUdBt16Ro423nmnfBVm6P9gh28JzSb2gUC3yzRJquJnNmkD5T0?=
 =?us-ascii?Q?rB3VxNZaTNcRHeZwN6DeTga8vUNxlZUs7se2EobYAca5KgzCyv2QktGPqY+L?=
 =?us-ascii?Q?qibkSR6A++8iJxGSrKk1iL92VObSFiSrmpICkr5Q4DH9B1v64wFbcdThIRVP?=
 =?us-ascii?Q?EwQJB/qTYnrfaL+Bf70QXlL0jYgjuSYW3GUuaCfwrj2bTf/Be3MRFE56e9vM?=
 =?us-ascii?Q?g7YfIBnZ+egtBMSy7Wru0A27+vs7zp71gfu9zgX7tHp70WPGWLvD2/4Lg2eN?=
 =?us-ascii?Q?QIHhhTpnOoCVLsvU/WoyUd9GT5geugGg1py538Edbq5omEIsTfnXHqq67++9?=
 =?us-ascii?Q?rwjsDdpFGkz775Oh40WsWODNxL8/7NWwbBP5KwLkq1R0BXja6/TXHKaln56h?=
 =?us-ascii?Q?xXRRApcA5FH6QITuoawcclZwGk3d9o16gM2D2+C+OYRZBvUMuHguZcDI7VPH?=
 =?us-ascii?Q?AhhLg4tNbW0UHYNDk1ag8bGFp2M3TiK09QNbuPMNsXDZkqib712ef72iVum3?=
 =?us-ascii?Q?8NVBsUGDmH/5KT8+kGlt/QXC3TS/T7ZuZHl5jgLPgoe/qgg0P1WFN83CxRF2?=
 =?us-ascii?Q?IAkRjBTUwSf7aJ7BhoFwYT93lFLZa4hXdIMONevv9OseZ9tVavmGMLamsMuT?=
 =?us-ascii?Q?l3LKAxEXcnz6zLhjD7a+fdPlUFWzk7UbQbpojeReDVJ84ZnpWz15YIC0GdO6?=
 =?us-ascii?Q?ckRlDqDF6yCxYCyy71skKvtlwfh2Kz5smMfdSzuzJsRBVNbdpeghu/fFm7zW?=
 =?us-ascii?Q?bdLasKNdO59sXsK6Y8psXaWvQHtjeYiv00wgZcFlpDA5ZIto1DKwDfpswIgB?=
 =?us-ascii?Q?vPq1GyToXl94Qp+TlNRoZe9GZ+bSjVEwKmRptPGx4bQjEIULzm0cR4JrG68m?=
 =?us-ascii?Q?BfXJPaHnHtjhDYBQwmmzMnxXm9ZOZhGaMt7AiysdzTw4Kg7ZQMjcBH4mba/Q?=
 =?us-ascii?Q?7NfqIad4cPjKzfH4tP46bsjupUhtYNY0Lp/e5lP+hArze+KGZKPuFJ5o9Siu?=
 =?us-ascii?Q?j+2fFEWc+MxO7HylrhGrcDEkC4vVrXS1UZ/xP2o1Rt3pJE3iEFLYozSqMZ7x?=
 =?us-ascii?Q?cWYn/D/JUwB2MtjxNS6s/FTrGTAAeUV8+zCQieoEUtH1502RiUvWLzJgSCKI?=
 =?us-ascii?Q?TG/tzui1cYFh+4VayZcXAL4/lbN/az0pNT1I1zkJxO33uwwI5gp1Eec/rWoN?=
 =?us-ascii?Q?uTE3DXReJAt2e1s88LecAAUHsJbgxxUSngfG/nTxmKvZFMSL43mwJFPppBxa?=
 =?us-ascii?Q?b8X/WwsvHbpJtZhR00FZ81oLO9IrpXy4jUYQuWvDl38URYchBaPdGx3JQVVC?=
 =?us-ascii?Q?kcwY3GXLiAwrMOg6OGzEDBU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74a5fe-2805-4f53-68f6-08dccb1c78e0
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:57:12.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTZnkr59RaJMKkwZKz2diuYNAG4GaJhI0VekH1eT7n81YDsNLLYDqHAQk8vtbk+MKGhKRITnvjLb23Z0fx611q4JgZzD73WPD+qwW3EJIk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3612

Adds the DTSI file for the Variscite VAR-SOM-MX8MP System on Module which
is delivered with the Variscite Symphony Evaluation Kit.

Initial support includes:
- Serial console
- eMMC
- SD card

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-var-som-symphony.dts |  11 +
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 360 ++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..03db6aef757d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -177,6 +177,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw73xx-2x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
new file mode 100644
index 000000000000..8cec3459722f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Variscite Ltd.
+ */
+
+#include "imx8mp-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8M-PLUS Symphony evaluation board";
+	compatible = "variscite,var-som-mx8mp-symphony", "variscite,var-som-mx8mp", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
new file mode 100644
index 000000000000..958fb7be3eed
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Variscite Ltd.
+ *
+ * Author: Tarang Raval <tarang.raval@siliconsignals.io>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx8mp.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8M-PLUS module";
+	compatible = "variscite,var-som-mx8mp", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+	
+	gpio-leds {
+	        compatible = "gpio-leds";
+	
+	        led-0 {
+	                function = LED_FUNCTION_POWER;
+	                gpios = <&pca9534 0 GPIO_ACTIVE_HIGH>;
+	                linux,default-trigger = "heartbeat";
+	        };
+	};
+	
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+	};
+
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+	        compatible = "regulator-fixed";
+	        regulator-name = "VSD_3V3";
+	        regulator-min-microvolt = <3300000>;
+	        regulator-max-microvolt = <3300000>;
+	        gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	        enable-active-high;
+	        startup-delay-us = <100>;
+	        off-on-delay-us = <12000>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
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
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
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
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+        clock-frequency = <400000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2c3>;
+        status = "okay";
+
+	/* GPIO expander */
+	pca9534: gpio@20 {
+	        compatible = "nxp,pca9534";
+	        reg = <0x20>;
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_pca9534>;
+	        gpio-controller;
+	        #gpio-cells = <2>;
+	        interrupt-parent = <&gpio1>;
+	        interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+	        wakeup-source;
+	
+	        usb3-sata-sel-hog {
+	                gpio-hog;
+	                gpios = <4 0>;
+	                output-low;
+	                line-name = "usb3_sata_sel";
+	        };
+	};
+};
+
+/* Console */
+&uart2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart2>;
+        status = "okay";
+};
+
+/* SD-card */
+&usdhc2 {
+        pinctrl-names = "default", "state_100mhz", "state_200mhz";
+        pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+        cd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+        vmmc-supply = <&reg_usdhc2_vmmc>;
+        bus-width = <4>;
+        status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__I2C1_SCL				0x400001c2
+			MX8MP_IOMUXC_SD1_DATA5__I2C1_SDA				0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL                                 0x400001c2
+	                MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA                                 0x400001c2
+	        >;
+	};
+
+	pinctrl_pca9534: pca9534grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15                             0xc0
+	        >;
+	};
+	
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04				0x1c0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+	        fsl,pins = <
+        	        MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX                            0x40
+                	MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX                            0x40
+        	>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14                             0x1c4
+	                MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22                               0x10
+	                MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12                               0xc0
+	        >;
+	};
+	
+	pinctrl_usdhc2: usdhc2grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x190
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d0
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d0
+	        >;
+	};
+	
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x194
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d4
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d4
+	        >;
+	};
+	
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x196
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d6
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d6
+	        >;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B				0xc6
+		>;
+	};
+};
-- 
2.34.1


