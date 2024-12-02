Return-Path: <linux-kernel+bounces-426826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48969DF929
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524FF280F28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4C3398B;
	Mon,  2 Dec 2024 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADYQHERi"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB2BAEF;
	Mon,  2 Dec 2024 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733108222; cv=fail; b=glEqSH46FflGCkMvMRVT3M19yuUUdR4i/PH803i1DBYXxRWIbwbf9TbU9cl6ip2o9rivYdfOaFhGPwI5fABlqsHeQVKoNFrbM2WlR6pdR52VsCQEQZaBKbS43DbGA0GraG0jH7QKrYBq/hFsHmgdQuFxUtt9uPtVAauiY5W2vj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733108222; c=relaxed/simple;
	bh=jlaNc/wdCaOjd2Q+ij5UD1uwAUoFaRxcBdKIXyCO6dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmKosMPP7+DjyX0lYlazuhF0HY7RgXWEyYwrCT9hUel9vQAqKH1h/2IbBxV3o5ka++Qc1lxsrvpqzFsyczJ3xoIqdsdVTcbMeJS8k2dO6maYKNv2QWAAhUOddftOQjbaKo6sal6n1q+LHlIu4DEXreU5LkSL7Dc4WX2gInI56ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ADYQHERi; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv/9RlpR07dKra8lZsWZksmpzdRtBf01xJV62cwv/wnecNZ1dhm33HF5twd/djlXdJ7xxBj2nzsMMi35ZTr8524KLg86/zGusj/V7uksv6NmL1WAt+82qgJULxorOZK7ScPUaFYqh9XJ6KJr2zq2NdGsAshhB1eGMkPhQmoww6hrZWzP0BHZs+0s7suB5NeVILoacB662J+KTQCbKHTiUBHrX0PhOJ9nwtVLQHtxvKkQF/njOvWpnTknJZqi5mpNBaKmVz7JevfxvgxIppNXS/vW5nPkpF83IgwntVCauexT31UnbQOZargCXc5113ovcAgE4QbdMgi2W06ltQCBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJLZuqEpwGyJh68XLzZb2awk1HoOYnEkTq7StmG7oVM=;
 b=TT36cC/r1QZ3v165Cv5A3X+pPTAVtbXeryH9C85A+nmQEvg6cuXS8UPAvpRGXp0USG9x8WXxH6v4h4ro3PBKijexe058l3Q1GK9DgbcGSIkfLdKV5nVyoCYK5yyD8feb2yiortpt8w11lxfW5/jDDKoH/nWvELfS+0lbMtJ/Go44s6ANqv+bmWgSZ1wXHYPU2I3EXncmCr/rehdNU4yjnbAcFbZwynXca5JGzNJwx89/wSUkGDFU9uX5uigcPKqkfHXuS0PL8mhLMUaOaLm6ntJWjMk7Wa99AlBktBQjywzpBgExhTG2KzGsxRm3v03KqQXhzlZ4ph/cgbvkfpAGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJLZuqEpwGyJh68XLzZb2awk1HoOYnEkTq7StmG7oVM=;
 b=ADYQHERiKIjZkpJyaoIgqI7KDpGFXp87kxcMGYnYf9E5Ke1La9wndUQFKbcSdOfzyJfcDMu7jqXeqe0ETdrkXcCkd38L2AR9stqTQn9zZ661vtGIt1yTu/lO5Fa1w9nuy+F5Tj32YSVJ6FwvNPZFnt7Jj2OLvOjDjj9+0xa1702s0XtlDAahG8j6IFZx1GdlDOZDEIdr8n8SpwXeNqjzOcThctevy4hQ0Cb1wLHfeHRjE5sZktmfFxg3hZNjucbbPmCT/bmCYgZq8s7JOUu7XRe7PiQUDAKwqeadFrn5wOkJY9FXPng0jj5fVHgDPugRUPhnRNev/aibcL4ECL3DUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 02:56:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 02:56:56 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	glx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v5 04/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller pixel engine
Date: Mon,  2 Dec 2024 10:56:20 +0800
Message-Id: <20241202025635.1274467-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202025635.1274467-1-victor.liu@nxp.com>
References: <20241202025635.1274467-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: aade7124-13b0-4665-7111-08dd127cfbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6WbJ38/kv5uPbAH5293dvJjQHFzKxPB55HrwepWM9a1dsrsxgE32zThhcJO?=
 =?us-ascii?Q?+qzF230DKXVVA9wfZMK6z5W8M/f9HT4JEstL2G0VgtY5Rcous6lMf5ULNwO2?=
 =?us-ascii?Q?HQwOH1Af/3/6S03R8nIHsj9mzjoGrAHjpemPLOURKsxqimif6aV4dLiexvbA?=
 =?us-ascii?Q?HcyK/R1qE/hkEelKzigSBhivbts+Bjx5GynLqk0TefrqD0Wqkfdthb2V/o6t?=
 =?us-ascii?Q?ksRPZCD5vTs4ZftPlW92au8Y4Lh66ZzJxaKJO/v+B911D4t+2N60xExjXy2f?=
 =?us-ascii?Q?85rXFOkiviqVmcYaEqR6DiHwymjug9KxCap8tQxp+ujLOYcPDZrN60o2qCBf?=
 =?us-ascii?Q?qPRR5aGwdqD9JBHkAdINk2fO0zgkFSJO2Yl/9Gkyb8fT8r4FKaDnYRN9Bd6m?=
 =?us-ascii?Q?KqqYRvKNJHVz9bMR1/UYI30iEeRRvBPIxaBfp6LgzU48AC2bZw02h0o6/0bB?=
 =?us-ascii?Q?AbfhPeahsDS3bIbo6ia44J2ZfMVijq8RcuMVPidIa+Ye3Paf4+Y9uhjRyMj7?=
 =?us-ascii?Q?gLo403bNfUGopGBQv++ErR6xgtTFxY5sguHvpCErjJOCOPTCopbQXdQ/Lqfv?=
 =?us-ascii?Q?RKRSYfnytU4m+G++UCzjSn7eBptCDVhpsZZUMZ9zyONJ9MYGXQXPBo7dK/Cv?=
 =?us-ascii?Q?Pne75AZ55J5SvwzK2ONja1W4h9CP9rVtOK4bLwRKyk4xSVu4Oyp9zpx/BnVW?=
 =?us-ascii?Q?GpLZ4D/qAt+yo1aLEqJL1bW1tQ+EqC+iEVTJ+HFSKEII0ClHO5mJgkNsiKiC?=
 =?us-ascii?Q?M+x+9GoQIbynXkQmhESyWB2ppEIaeuvYlTAFhcKOz5drJmv2aEmDqmtAJh1Z?=
 =?us-ascii?Q?bb8r6PoYToz9t8CgQ7ljIrMUNiuxFGMd8e3Yrm2AIN/TbRrpimSCXxOpPv18?=
 =?us-ascii?Q?kKLxaL/Mobscm/NVTTtBu3xHkIPgGrSto39MyS+7dCrxEEL8jgs+TYiYUtt0?=
 =?us-ascii?Q?cF6VhsQKO/cgeIcyJgFr1o5St7tZ6eX4M2b0upVtcDw0P44yHUqA2TNCl6/d?=
 =?us-ascii?Q?9z+s3mTXCChmfDfsL8i4BwmkZVquN0l/JPYQtMBTqrkemC0Kxnvquj4V9mxA?=
 =?us-ascii?Q?LPo26ELW2T6z2+bk2KnnpUeZMl8GdKx7SEj6l/iCMFlmuHK6l65R8z6qamWC?=
 =?us-ascii?Q?6Z+yJ+OT9uTBy1t4TvjOJwkLlT+i+ehHwqUDnZSpL36VicNS+QrathrLY2pm?=
 =?us-ascii?Q?gD+xhkdgp/dO8G2eI2V+VuSn6fnH8jAu3hjI4KBAhyw+Q63CfDgbmT8kLbmw?=
 =?us-ascii?Q?J07qP5Gl5e7coJrMgjIX9w1L2viRB/RnR75Ml30T9Zdgv0qMgv2fLX2TkAuf?=
 =?us-ascii?Q?IVtLzP9LBN6id5a6VjLkZbu0k2Y72YhDsWg+S1A0Px+3GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4l18le09FyCW6OMtOSJUT2aiRAQQ4OSYxGy4byfYxknGawmw5kuAI8rnYQCG?=
 =?us-ascii?Q?TFKv4XPs7YYmMuVnnEgW2Fq6eGXqM/ZnGPnv0gCUDr+2sKmvzppe79uPXKxU?=
 =?us-ascii?Q?dedVYGJe0DZa+O+C8LgAgwmhhJ3Z6ghESm/PwpcttvV/5A8iaEbJ5Clk7oDn?=
 =?us-ascii?Q?YmDlYKx37POSLkM8piCMU5f/bSeCRWsO9YanZDRJ9s2TK2BgpGEx1i9DN9gb?=
 =?us-ascii?Q?Cp5t2KH7z4sXN5XyGtIYbiL/OY0I4UuygSyB+0+WaE80TPK02/sTgaO7rt+5?=
 =?us-ascii?Q?MSdZhobk7s6465XOvuGYVyx/H7xv5khC/YM+xT4NVTosOZpd1nX5gnxk7zz0?=
 =?us-ascii?Q?KqxyhC980uQ80c+dKrlRNlw7cE+gcZx5EzqIukYUVJK6jHNYqZryaK9Y+FwX?=
 =?us-ascii?Q?qv8AwHholIOL5wcV0G2PHTyX8qP3rk6iJCxdiCqWxaKWtBQipmPAZDRHY24e?=
 =?us-ascii?Q?s+cIvE0kbC9gs3hlg6nkOy2/BwLtyovVzp5kOwPVQ0ptpFLwcmJCudN4xl0C?=
 =?us-ascii?Q?cN3pkD/Gv9f48dZgWGYH9vg8bU3KkxgZGV3WeZUqEd2vuPDBC4gnl9RiFYSG?=
 =?us-ascii?Q?6C/wefFl1ZEauqhzkgW2OkyfUyl/qWcwPo0v2CQmqKJcV0BP7a+SPpdSyrec?=
 =?us-ascii?Q?0dkrxXr7EbqZeE3n1UqVhuBZu7k5UxK0+Uu1tgqZRvroeQqT2iCbMGQPUuuL?=
 =?us-ascii?Q?wyKeb+2Jn6rUwIk3H2Z9ABM7tBrzCpzSnobdN8EmxPPYuT0xGBlYlmJ/F1ic?=
 =?us-ascii?Q?lfMBrH1aFSG4CQAuSD8lwIjW59HBTeg2CVjnU3JCPOPoG/51JSmXsfOaFC2T?=
 =?us-ascii?Q?5xGmJhl9PxYEqSCVivZH4P9oXhFFYtO2zPZrByFECLS0W5Gx8k6pBPLopVhq?=
 =?us-ascii?Q?2p1E8KkUw9B4A4A2E4EvMvQYWfbPZQZraLwcE62/Qi+HGnhk6AjVzbsZ1cHC?=
 =?us-ascii?Q?DxzdE48/GT4ACATXetIcMyUOgD7fMTCknxCB5T+qvkDKxhtVH9xOLLtFeia9?=
 =?us-ascii?Q?/6sRKyKapAkJzsraheNHRPy0cZYGykS4UxljcV2pXuKkG58uNVxAjLSesZhB?=
 =?us-ascii?Q?yEHutyz7eBvN0+M/HJQiHUlr/hj/ldIFcvVz/IaZA403tJGlaeR/+4Ks71nT?=
 =?us-ascii?Q?LMwFQ2bGBy4355RyuWvpc/Umdp4MJVwCyubVZx5jCjNbHKhMbsPQWhwcmBxU?=
 =?us-ascii?Q?6TyHZuUPo8DpQNgoMMoRVrf+19xNSom5nDAbY5BKtunGi8C3f9hETjGFG9bD?=
 =?us-ascii?Q?xBMWZihzuJqkDCDLDpjiFXUww3u9rSd32ATvNdtvHEZ+E0jQc5NNpUKKdgwv?=
 =?us-ascii?Q?y5OBSzCngKyQQhYbJuKjGVkyamdKBLaMDtzEIcUFn4Dnf7IUbUaalB1LIZth?=
 =?us-ascii?Q?+boSgrW4rHwDrbmIj7M7r1w4Jrx49WyIw7fnYk9qG1p7c9yqT/Ufdo3Tuk+M?=
 =?us-ascii?Q?IwlASEk85et8fnXPuUJP0/RcEuQJQ722vKMrilBIa7JlYWE1ySIHgH2K8zbK?=
 =?us-ascii?Q?YpugcBjewsOSDPlOGHDLIHPm8FwQjb0Lxu73ahFZ/g+8ZllWb4ttRZzB7OqT?=
 =?us-ascii?Q?QfdmHHolL3DjB8gKI4za6vwXPBT/jwVE/tEXGNzZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aade7124-13b0-4665-7111-08dd127cfbaf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 02:56:56.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx6CQzWrLL8uuw4cXHmd9QhSWIIqnkg0JPbBvC2UZwgUtqMasXEG+QNyrl8vrMTbuh0xicKIAg7z3Ic0QQKmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

i.MX8qxp Display Controller pixel engine consists of all processing units
that operate in the AXI bus clock domain.  Command sequencer and interrupt
controller of the Display Controller work with AXI bus clock, but they are
not in pixel engine.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
* No change.

v4:
* Collect Rob's R-b tag.

v3:
* No change.

v2:
* Drop fsl,dc-*-id DT properties from example. (Krzysztof)
* Fix register range sizes in example.

 .../imx/fsl,imx8qxp-dc-pixel-engine.yaml      | 250 ++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
new file mode 100644
index 000000000000..633443a6cc38
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
@@ -0,0 +1,250 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller Pixel Engine
+
+description:
+  All Processing Units that operate in the AXI bus clock domain. Pixel
+  pipelines have the ability to stall when a destination is busy. Implements
+  all communication to memory resources and most of the image processing
+  functions. Interconnection of Processing Units is re-configurable.
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-pixel-engine
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^blit-engine@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-blit-engine
+
+  "^constframe@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-constframe
+
+  "^extdst@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-extdst
+
+  "^fetchdecode@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchdecode
+
+  "^fetcheco@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetcheco
+
+  "^fetchlayer@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchlayer
+
+  "^fetchwarp@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchwarp
+
+  "^hscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-hscaler
+
+  "^layerblend@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-layerblend
+
+  "^matrix@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-matrix
+
+  "^safety@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-safety
+
+  "^vscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-vscaler
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+
+    pixel-engine@56180800 {
+        compatible = "fsl,imx8qxp-dc-pixel-engine";
+        reg = <0x56180800 0xac00>;
+        clocks = <&dc0_lpcg IMX_LPCG_CLK_5>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        constframe@56180960 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x56180960 0xc>, <0x56184400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180980 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180980 0x1c>, <0x56184800 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <3>, <4>, <5>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@561809a0 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x561809a0 0xc>, <0x56184c00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@561809c0 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x561809c0 0x1c>, <0x56185000 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <6>, <7>, <8>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@561809e0 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x561809e0 0xc>, <0x56185400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180a00 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180a00 0x1c>, <0x56185800 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <9>, <10>, <11>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@56180a20 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x56180a20 0xc>, <0x56185c00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180a40 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180a40 0x1c>, <0x56186000 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <12>, <13>, <14>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        fetchwarp@56180a60 {
+            compatible = "fsl,imx8qxp-dc-fetchwarp";
+            reg = <0x56180a60 0x10>, <0x56186400 0x190>;
+            reg-names = "pec", "cfg";
+        };
+
+        fetchlayer@56180ac0 {
+            compatible = "fsl,imx8qxp-dc-fetchlayer";
+            reg = <0x56180ac0 0xc>, <0x56188400 0x404>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180ba0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180ba0 0x10>, <0x5618a400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180bc0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180bc0 0x10>, <0x5618a800 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180be0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180be0 0x10>, <0x5618ac00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180c00 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180c00 0x10>, <0x5618b000 0x20>;
+            reg-names = "pec", "cfg";
+        };
+    };
-- 
2.34.1


