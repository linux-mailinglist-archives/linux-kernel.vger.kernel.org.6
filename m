Return-Path: <linux-kernel+bounces-260814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D8693AED7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4FC2839CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233A155385;
	Wed, 24 Jul 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L83/6Ow7"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DC155342;
	Wed, 24 Jul 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812901; cv=fail; b=dJ8hUxXN5EirwvIuphtmZusen0Ym44IoByXpQGJfHnehCy+hvscV0XRXDjl5spC1/g3Bz0gNuhEg/tgFhlCguHUdBP3efJBLv2buEg0R1+c5zyqQgrSbv/l0bsZkMKHxkeWlYq0pCkT3DKLGhhXmS3izfYMZzfGnXK3eN0qilOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812901; c=relaxed/simple;
	bh=JLiaNCtrBEH5JMo3z7gVv+VEBk2n2+p+2yj1gvKDfCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQNBY3Q9tFylfoQ6gnwuCKKvVa2AWIRZYfXFshv6jqvHPmVWFb45o/yW342HC8Y6FypiRXj2X0QsL6KhRuAFaVsQjcF1z/R3LOfy7G1hdCscgTEKcWMTxQBZ01fgowiAjsX/tBIwODPBbuOtBuq9Q2+VDwFzdk2vmYDNvTGaX0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L83/6Ow7; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6H/f2bJbaxpzAiZNDXriLvnsvnERA0ahNZpRN3WRJK3II0SxtPzYHCnN+gOzwkzdiGjhoH/YhI5t5gO4kvcnlskdaibc2xeJslIA8WYWNcAGt3Dzpsh+jRPlCtLlq4lRJxkkieBP9TDjQF19i7drbxVOfXJqaJrujYksCxG1cSxdIR0dEGQMen4sYkOflQnx7ftMsXrbjWyDijjLnrO/iwXmBP/w4hb5UaalXHqereaAvFN3MYpAPRm3l42StK/qXP+zZQlAkEZnMUphOdCiyqsofj1TkagePslJSJ1rQR5O+IvKHdXx5DJNde8GA/Oh+jE7Wmpn/HdVWgCZo8zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evr3+PtWF6Swhq9XWIO7OQj+wE1GEtG8uOLe+3FqIY8=;
 b=l+M062NfQ7sAkqsnzT5pYWq9ouX6OeR9yN8WMA0jyv0x5IinLW+heUFFn093x4610rFu1YzyAxuFijd+aDOPBHPQU20kMmpytSJDc68Jf8mDY1OalNrEHfhxk4/GjdiV+tV2ZcsvJDHMnOXS1PsmOYhktcQFa3abdgHa0oDuemy3S+2U3NP0OIIjejKiLNSacubmmFrBiWNLVeBupr5nnT4jNV0KZHi0abW8KYA0RxWQy9advmNVITzyuoFX40Iyqxd1zEyfDEQfDVc3wN0aBMkJxPzQ/WjAXeHScpWZSdXSzbYtdncht+3W5fgoio8KQW2Np4ppN8NUE3wCtxeQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evr3+PtWF6Swhq9XWIO7OQj+wE1GEtG8uOLe+3FqIY8=;
 b=L83/6Ow7/tQhdHCwSvTiZui57jRiT2+LTGUkKQ3/0jDYEj2SKujFvTNTOO05/+m4ecfVVc6TEMgTbexy6TnBUNW8/WgaaWooUBv02zYupu8pzgFWFDIyfUdEBEcO4maZaZVH6pQP3flw1Uaz1QTRizUSPpB0mbx/syuxnuTgEHU1LWPBTMmecjpre7foR95zmYU0NsznZhK28/VeOPTvsfjPlky7r3neLdOEGKAtD4rORpsZaLSJOHIIH6/rwnx+3AUOvgfdUXrOipNfdKbt24OpTuAiHhvSYM1Nxo36rXH/pHFyj5gZCgpxB8xdMsR6UZ2uMP46TGIzUmeVB+R5Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8040.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 09:21:36 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 09:21:36 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	tglx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com
Subject: [PATCH v3 05/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller AXI performance counter
Date: Wed, 24 Jul 2024 17:29:36 +0800
Message-Id: <20240724092950.752536-6-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240724092950.752536-1-victor.liu@nxp.com>
References: <20240724092950.752536-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eabb3f0-113e-43be-8c65-08dcabc2042f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kk06ijqEleHUFB+cBNpzphRlzhFBY9bwzrjxDcJKoVWCPkvLrvuVeUsXBXya?=
 =?us-ascii?Q?gp51STKLWDCnDIQ0TuUfnQ5j8RIePmiGkKX5NOkb0RAipsfhHorJdgnpsYoF?=
 =?us-ascii?Q?XRCODKRfXDxK9td7ROLk+K4zKaAu8ET5c+uTJT69ajGI/0alCHH8m+BMBhOY?=
 =?us-ascii?Q?/m81eikp9yCmHodcqHOIMmN93b5JFd6jhSdk7bvTyl05Qb6+YhLLwbCa0u/3?=
 =?us-ascii?Q?Xqy6haSo1JRrB103URW1+OaIJzKNoZXSKt5eABvmshzmHK1L4ak6h7JZvnEg?=
 =?us-ascii?Q?rZP/QDhYPyom8oSYBSdtT/Nq0sIORv6u9YmgcHaXEOCQM+fA7cfW+W1xibgc?=
 =?us-ascii?Q?L4Cn3WEtnVbrJ2mH1akURUiu8OGsFLgzLhLgUVHhtfViY87nbVKCwCkcS5iK?=
 =?us-ascii?Q?oZ74J0/be2Yhmbjic3e3HWrjjxoTSWc1ozntc1fEJNfas2oZTn4CkF0Gzx+8?=
 =?us-ascii?Q?Pxu8sle6iFai/ikusukM9lr0ZUbsFK4f2178Z0RT091w94knL7cf4LfsDRMg?=
 =?us-ascii?Q?VoOH0Y8KM1RzZGdti88PXxufvD9dyTqTfXvApok59HG4aRvA+9zzoHzHySiJ?=
 =?us-ascii?Q?rs0q5cYlmuhM4yPmIzT5VDQJiEPcE/sEDiA5gMWeMAfdq/ldNxTCbN4Ii+sx?=
 =?us-ascii?Q?5tGRP6i1U/gTtX9BP4OGU4RuXEM/H/vy6oG9dNKjAwAveIwVItTVGCt1AujU?=
 =?us-ascii?Q?5QfzzsIHvIntj4otJhds8bdOBqJIlhjXrfuZwuwb4KxTAYH57o2M7khnTLi+?=
 =?us-ascii?Q?ZyuZ0Oet8Oo7o3UUVykN+aLSaJ+/jq+YdgpF3yBCt6EDjpNStYuVPWlPUWCJ?=
 =?us-ascii?Q?uB/E1/QiUBudrSk9OCnvcqM7q/p1vlK7nRRA6TP39ET/YvenmaBAP2ix5cCQ?=
 =?us-ascii?Q?AYHj9JzbS0ktskb+AYY9ml25tO6XSARgHxaQ2mF260M6UfXapbKpKOcpJOqz?=
 =?us-ascii?Q?g4xAAjBz/sNKVpa9U6a8xsKEjyMZK7ogv3Yb2kQXvdwtXGmy+rKIgA889q5L?=
 =?us-ascii?Q?s8tiWJpR7l8ha1jLfH/SgNjnY88oyn1wumJTXYGw24ovCBxDhf7OWvk4ehNf?=
 =?us-ascii?Q?j6g09E0pAIIu6JjjcYhbKW2IZBkVv5b8pqJYTF3hB+CrwrFxWkzzafuaCNFc?=
 =?us-ascii?Q?Ilo3cy2yWFi20gUvh7iI7Vpg7mbp8cuPbwxBRpCMVH+KMeBw/fhSZoEiAPCy?=
 =?us-ascii?Q?z1yOXFnt44xGPfoZ/l17Nnzjv8b2fezcsNOuO2Os6jfyojNV+GPrrcbEuLYE?=
 =?us-ascii?Q?wqZgXc9grXGH0Zo8YvZnISEd7nTB26a6kqf1nYToFVIpFFQee5roKv3mGZgD?=
 =?us-ascii?Q?IReBf+Is3sb+OVpbdNhFmzWZ9e41pX6Inz6GI+r5bR/A1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3flbGwH0peu1+WDTlsXJ5or2Tkgt/nTdkzFbMTdEp7eLXz3dx7gwn+U5efc?=
 =?us-ascii?Q?DgeFb8AHC18nuf13tptMEHUpDNOz6udNp/aStuPs2rQWgyrt1qhyw766DDbj?=
 =?us-ascii?Q?dTbH55r1hRfhjKsRoAj3x+6u2Q9q6hdOnaFfvxuokdpPSZISCSWHkrL0v9Ba?=
 =?us-ascii?Q?oes2K5DVYupXvZ2RWjNDa8RHWmQRXJyqioNTbcZq9jlTR9cjlgTSTSeL5J/u?=
 =?us-ascii?Q?aPZmmeV14LulutSRIc0OrbwX+4a5S/e4+eSW8Z9/MITsbXlyc7ZBEatnNCvF?=
 =?us-ascii?Q?wexqtUW/x+XWKoaQKVlpA47hgN9dMsSKL/+It1U5M0B1HgmMgkZJFzrwt6TU?=
 =?us-ascii?Q?T6MNvYX9X1p5ztnFAg3+DR3zgWwvT/mePBWT/kHl8+dSCX30PBtuizsqLMFy?=
 =?us-ascii?Q?UzlMsMcsFwziRmVUT9lUPlpPNNG0LF86Z9kpOqfze16afVeh9++ZJtoDsj55?=
 =?us-ascii?Q?Ggj93OqfbucCQqg+uBAC060NOLGQSXF/v7fU9vcbogJwkSvo+eZmwpM3V77i?=
 =?us-ascii?Q?SyAtsH8JVIUCxaBuqJiqsZutpCPwbsfpPIAfHH2RUwBGvvvyIGYDAEKQ7rA9?=
 =?us-ascii?Q?fuN1AajkBqNuvZutgczXkp1uOnwe8IQZSTMOSK65fyBuB3d84F9rNW4SIV9y?=
 =?us-ascii?Q?HBDaZLsU3/SvX5anNL2neKYpO4gzELauALJ8LS3pHn7wl8+qkOJ2vGSA4mEC?=
 =?us-ascii?Q?fFz2SXBBNSPwsGrdw/G56NfAnVtiC1r1M8fmhyCO48G374SAfnw7zHbkqMhv?=
 =?us-ascii?Q?Z7O/fxn3sCyYfYbD9FmY7Zjsc4duUQo16Usqxc6Ulh+rz57h2GrCvJIiUctL?=
 =?us-ascii?Q?IAZ4wmgMK95LmofhrKKkKUO12ChjlfvFk0kKF8doXum6WlykqxavlOnn7e/C?=
 =?us-ascii?Q?2pjJ4EGDJOcNwMD+htFAIa708UUc+h6W+4nBH/UmsleEqjTJtZ5cqRkqgtJd?=
 =?us-ascii?Q?Xg21l2U26wmszRq+M9vu77XSnxyc3bj0kRIC55JU7NFhR/s08LbLMju2hIdJ?=
 =?us-ascii?Q?I+L51v6AZsyfxcEhw8G8dqR2nqMQI6/KqvKDlBd3UbCLL7uOJ3yP9QCmWyCu?=
 =?us-ascii?Q?M9vN0rLnbfKf8+5pazKztWW9UAddWIFVZdVgt2+ZvXJT0ub6kwj42nfvVXre?=
 =?us-ascii?Q?7P/AEzmZdSUMRJ9qNrmZEjuiOpN6bOjMb5PWpQZsRrjPgP87OD1LsYC7Ksip?=
 =?us-ascii?Q?8gJnE/4bOohbmjm4NdWAHT5InnlvRY+ZBIxeFkwOgwHZXgu8DZ5pYyEW47Y0?=
 =?us-ascii?Q?AIVrlc5Q9Oyjdam0Db6/GSzRdhAng1AHVIfeSzUB67EGVZVQmSGNBciQAyna?=
 =?us-ascii?Q?Ww5MBhy1nkhmUr7nc62XjZb7hO0dvFWFtmlWtegYzvn4Kxhn+CJiOZMFOwpu?=
 =?us-ascii?Q?hhZnEV8TM08XzbzZvnL+JCS4MRK9AacLogw+UBLPwECkBpJNYpJPFNLCtXdY?=
 =?us-ascii?Q?nBFDAv1uPMVnyklbzdVSlVX0I2jV8kmRCymfpLdQAypVCylNr+o8h+lMzC0N?=
 =?us-ascii?Q?MPjVr03fz/nVmpPjwvQnakiZKuWsJifmmDJNfJlqSuNvPhINN1HVX3gjxBej?=
 =?us-ascii?Q?LkOPUPL/RqZdOc9u1RCWn/UyY/JPmsGswRVhygyU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eabb3f0-113e-43be-8c65-08dcabc2042f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 09:21:36.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EC4nrHalsfY/jaebM9XCU6iex7m2g2j5vfSnPB48douA9MM0mDz8NhJzhpyiDAM8EYd0J/SPQYkoqmWc+DRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8040

i.MX8qxp Display Controller contains a AXI performance counter which allows
measurement of average bandwidth and latency during operation.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3:
* New patch. (Rob)

 ...sl,imx8qxp-dc-axi-performance-counter.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml
new file mode 100644
index 000000000000..1d6501afc7f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller AXI Performance Counter
+
+description: |
+  Performance counters are provided to allow measurement of average bandwidth
+  and latency during operation. The following features are supported:
+
+  * Manual and timer controlled measurement mode.
+
+  * Measurement counters:
+    - GLOBAL_COUNTER for overall measurement time
+    - BUSY_COUNTER for number of data bus busy cycles
+    - DATA_COUNTER for number of data transfer cycles
+    - TRANSFER_COUNTER for number of transfers
+    - ADDRBUSY_COUNTER for number of address bus busy cycles
+    - LATENCY_COUNTER for average latency
+
+  * Counter overflow detection.
+
+  * Outstanding Transfer Counters (OTC) which are used for latency measurement
+    have to run immediately after reset, but can be disabled by software when
+    there is no need for latency measurement.
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-axi-performance-counter
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+
+    pmu@5618f000 {
+        compatible = "fsl,imx8qxp-dc-axi-performance-counter";
+        reg = <0x5618f000 0x90>;
+        clocks = <&dc0_lpcg IMX_LPCG_CLK_5>;
+    };
-- 
2.34.1


