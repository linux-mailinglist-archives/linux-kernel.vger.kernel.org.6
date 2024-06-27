Return-Path: <linux-kernel+bounces-232501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4191A9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77C4B26A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E366198A2E;
	Thu, 27 Jun 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxlm2ZN7"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365931822FA;
	Thu, 27 Jun 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499714; cv=fail; b=SQa+4qLdUTzWYH5uX36hG98wdEvCHmS2/ND8JuCsxg12D/gTUXPUtbpsHT0W0WJi2cCAgbe6dxMAWOir/u6Hn70I2hAZ0dPCniHacjG5marqloG5AQZp24yqEWFfZtmtw5P+jKpFJIgxtH09abp0hAo0/S/JJ+uqucQYyXsMeQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499714; c=relaxed/simple;
	bh=fj5lAcmG7ZC/CWhDGC4m0NN6KqhIkzx9K+OoWeTnVns=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s99+rX8NZZSu/tpiO8i84Q7IXQOm2r8bZW+1MZP42oBIZL5Q3MzmyK3pbJV5zeZOigtJsdB4Mc3ohJ+xPqrLX1yRmwTaiaGqxLeEvYUkf6gUjcP3j/fJno7rGw3gzOEAEfMTR3Sm6xTLFn6F9fZzsN8sxAb7itf6eRFRHbBd2Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jxlm2ZN7; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aImYsNEd6Z6UIZjJfrkfX5HCFjq2joT4zxCC8pHI9yhzv6ZRglhYEhU8qNg7zlS4g4iNsHTzN/aAunXQSJa4nxPgb45EP1wVFPCp7BaY0Yj6S3yE6V5qq/Ll8Kaxnvg2pjwgklSQw4Ny2Ms6/iFcG4GVcvWd7gc/Ij0y+H+p8hB50A/WR1EDXOra5ZC4/zz2dJBSHNxsaBaM3O0NaXNjIjS37qMpchQTGkaMY5LLkdXRFWt43PPhSoihoMEMbzkmqphmLHvL3EVw2jFxYWQbDl7ZAVMIRpxQPfrqHnefj+y08iDl+3+XBUjrVr2AQGhVYwoGPwHAzCsesyYRywtJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xVhZQkbJNgW7waKjsbuOc1q6thPHQ+HLtxRT5U/XMs=;
 b=kgMAVCwve6AM/8cnMzUhd6fj012OzwkOSLHJqg4UTeLsJJzK6MU3QNBuJ63H5/5mXxc3NaenzQ6htihizf0krBw/ebFdTn0feUA+E9MY1eiTvd7G5Bolyelh0Co5lQdJ+62POuEWTlbwwI8RIJUSVkciG1RtBEA3y/+mOySYBQ0/SLfCx58H6JEZRT75dQEwGRsL+gQw1+x35evy+Jmw3jmdB0QyG79wSG5a/ymrSFox9yXDN48HGxHxAiowxus9RC/6wqPs4f3bi5ekiN3B8IsV8Cj3AhRvzuINNInpa10hp8YNtNGsa2indaUPGTmtBgQFyGtZUn4WWhMaERl6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xVhZQkbJNgW7waKjsbuOc1q6thPHQ+HLtxRT5U/XMs=;
 b=jxlm2ZN7ZPcrAu/CqsyPKx+hkGgDfizBKXYwXbkYODw2xSBYx646iEd+pXMScSS5f4hRRO9dX9ZUIIpbEX6roLv1qU9pyQ70zHd/aW+q5X7vfdGlSKmylzG8WjwxuLpih9dXyF3dYwpLYst5T1oIkQc7jswux4+Yo+fpQXCcFTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:48:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 14:48:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v2 1/1] dt-bindings: usb: Convert fsl-usb to yaml
Date: Thu, 27 Jun 2024 10:48:15 -0400
Message-Id: <20240627144815.4014179-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea57502-5b81-4413-1b79-08dc96b8346e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thUNXXrAdzZ78a8GaJ8fUkoVkr/2ONgN9uR7XFrMr6QNGjHEgbuwI5mmadK/?=
 =?us-ascii?Q?jjTAzeeswRt6vXnNHNKfgRnD/LiPnq995+ovraiTYemvrH3l8BWKhednY6ON?=
 =?us-ascii?Q?fRUfN+YkPTuJyzRinEa1yFOQkgbWm0lCn9NrzdKaBmHjYMKFH+MlrRIVQxF0?=
 =?us-ascii?Q?cYXbRA/i9UfrzHeRAeXNCktXQG3f9n8xxy3+NxgSH5wnF3NKrsTiMk4WpTyc?=
 =?us-ascii?Q?gk9+LsxT14OqMLVsUH8Nxl6UeP/dsODZlDGhF/r8llcsvOCrIyPIy0q7GV8z?=
 =?us-ascii?Q?rvn9seYMh0RGNda88XSU39MrVi3CK/SI1Iv8fS8vY2jbG0/g4cKmQLZcvtO9?=
 =?us-ascii?Q?zUvdGOALz3iSTwYJNjGcohzcYGBKyz4UMvq2yQQhHXuFsdJwVpQojHbMjPig?=
 =?us-ascii?Q?b/8Jimeso1zeH+whk4q5XeqXqzu4TQb4j5mMFujdBlU3b7c91Gv3fEozvPmI?=
 =?us-ascii?Q?Nqft9JrNij7aiB9N/hRV7k/F2reJt+TOMUwCmBgxS6nYdc++6eKNXOwbhZp6?=
 =?us-ascii?Q?vQPY7el1o3fGDX0AFdWUVxbnik+iJ6sQO12uuP4ZHWjE8DwV/joNp987FSVv?=
 =?us-ascii?Q?i86UNgsD3NX+Pv0Cw/Q11e8Dlq7MFQ0Jar5yb8PWfZpyYblkyayuf18apL0w?=
 =?us-ascii?Q?SYXmTWRtF8itMZbbAyzPLPElnRjMy3gd3s4BwrgBTh/dlE8B6QPUYl6sR1kz?=
 =?us-ascii?Q?oI5I4+SFspTKDKt9kjwO9IjyKPsZLwE962JDz8TnIJ+IE+c4lTJSkwkkt9gv?=
 =?us-ascii?Q?CyvuG2OCO4eJd4AfA97n4b4sE2a2B2qfMJtm2Rn18tAdIQMFwX8MKYEwiexN?=
 =?us-ascii?Q?foIRMwwTCSLIa/5j/bILP3r/TgPm7iIkgPGcb2Bm1suBM5qdewg5UOh0NpBv?=
 =?us-ascii?Q?o4jYo/uYP/Hg3jvNC7/9jGSN78Fh0S/4NTjFdf5BkzZVVH82sGISMT/AjHAY?=
 =?us-ascii?Q?jkwEMI2ydaSzt/eq8uXGz1ZoCJcJ5h7B8QZfJRnglmZGqHLKV3gJ1ZEyGOVt?=
 =?us-ascii?Q?U7TUY237wIbipM5R3EKkZS6TvzTg7RmpA1qrA1TE1/QuVMJjqtasM30vGMj5?=
 =?us-ascii?Q?WxPE/Yin+QtJKqCA12e1Oe7LBgkMjMnrbfz4gJaMfs3XwMkyiAgaTs5XsJ3z?=
 =?us-ascii?Q?MqqmFdr9OyKPqBHVxqk80Qbr+ldTAewnVdjAH54td+x+vpFgC2Ayez+G19p9?=
 =?us-ascii?Q?wxIJolev8oC9vuQKIMaxSP/Xa8sdzyTzWPrcB/Vx7l8Y1xgV7e+FUq/9oXk8?=
 =?us-ascii?Q?TGxIe6I55snNIjAXjCl92QGZXWBx7XTdEeYJTZANbphKVsvfK/6GG3Iha1KV?=
 =?us-ascii?Q?JJvHe783kom5nOy/OoGH1g4QRTKbSLeeEj7xH3+fzLQidg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hRdEFGSEZwO0T+5FHWQt2TbX5Nba3k9vYcNeUhtfKStD6MeFZZHa4WYghMHe?=
 =?us-ascii?Q?Ss23NwkniV8O063GACz8xWy0fQEWuGHoVAekRwyfjnYej3UxEJQBIDmBO1id?=
 =?us-ascii?Q?gqhDDUR26lYjbIIYSWoMbeR21SnkrV+nlOswLfH+T1mdjEnTV+1QFu7bxVR6?=
 =?us-ascii?Q?aK5dg3EjzlP8Ri6tVZWvQcsaE0vcdLfXLJhedSjqNUkmpXuCC2MJaASYsyWn?=
 =?us-ascii?Q?9YBQVoOhQbthV7OujtHvbcC26Z1UObgcHl0oNT+/oe/FgZV5i7ElwPi/ElbX?=
 =?us-ascii?Q?piS5lntIQK239maYnepQuGlCq5KFs4ehILMI/G3bbq3mgfCJzZT5o71GKias?=
 =?us-ascii?Q?GD3xay6MnFkbhUe07pssUjuhaGEyIRt2mIk5Tdw3+ipYBEtAkDcL4ba/oQ3S?=
 =?us-ascii?Q?Q/1uqlsJKqSRIcFfkYf7NLdE41e7eDAqskLVLeZO5ANlbnwNCeRAIc+WaSBZ?=
 =?us-ascii?Q?qiQU0ZfT3T47mrwQLxcudGKEXKlLpE7JEkyH2Thkc9AGRMwtnUQaxIF3Z/dt?=
 =?us-ascii?Q?bvO1BxEjjpKTGgX0Wp4PUPg2karldcZmp0i3g8P2VmV/fUPrdPa77yGmW6m6?=
 =?us-ascii?Q?eW11OGS7H5ZjK+H8X1XdowJN0WSNTHQE2PingRR3//OPvOg1obUI2rXa8cpP?=
 =?us-ascii?Q?eOaLtv4Q978h1poN9vA87vKE1oF8b9XHyRrMwRJN0hFovnvdTsFc4P+/oUWp?=
 =?us-ascii?Q?XhugGRSq33nNgUPQOsHw4yoJWdB7peRHuqYDlizC/8rLkD5IlqzeemcAjv0k?=
 =?us-ascii?Q?sK0MGiG7LEu0uPa1Uzzp1oxMyRRQLxZSSJy/W3jIBwtMBu1hbbUqitXK7KSm?=
 =?us-ascii?Q?X0G7lmWWqgu1L40BumdLoXtZ6yfntNXDb5hjnBLKrLr/Cft/3sOjFb8CXUic?=
 =?us-ascii?Q?8Ka5KzQKP6QFu+4sNV+qpctdPJD6VJZFW5hUhGZAPyk/IlT9VJ7YV3Z7AAbL?=
 =?us-ascii?Q?g/4bPwGqzBuky2FEhfH6hFszR3S8cxIsA3PTcxMpiIgKBCy3C6hFBUPqzxrv?=
 =?us-ascii?Q?z7K17YFqDGK/10TYTUqcv00vajDXeNX4FCc4b2lPNJPnFZS6t8dcXG1vhXFL?=
 =?us-ascii?Q?XGEXX1eSHa2E0+BJ4bE26zH2A+zJ56F1iCuDn3HOepuYWOCB0GgT+COWZGg9?=
 =?us-ascii?Q?HTNCnD4AHUSXBVefV7jpdq8/ay2BPkzaiR1WMPkERPQsqcyHjVduYKPOk9J2?=
 =?us-ascii?Q?hJS1SZJufGbQd3GWXbmJ40YbrrHk9H1CeJs1VVxONjOGN7sYeYBRodEW96lK?=
 =?us-ascii?Q?qlCc2OOKqa6Iup2UN5uPk6AYWdwPJrVc6FD6AwjwVWBlBjPfPJLvIo7KXvOt?=
 =?us-ascii?Q?hZuwY2aT/v5fSFp0va3POOSs3ZdYqh3dhdVua7xko+3UJ7fZJXwHJiSCK4TN?=
 =?us-ascii?Q?flsSFcCvfdV/gAVP2WVqdvUEzPuy/4kFVyg1Gem4WMt+eL1J08kE0KtPIoHc?=
 =?us-ascii?Q?0ENJgoWe4/vl1ZiTnw1G9dGGC/DoUJGJXX5AOIeDJs+tttAfHX5rF3SisalC?=
 =?us-ascii?Q?2d0AfqlAC/wCjDfUrnMg/sfOfuCA1khOieUonNI0oB3mBoZPRGiAd1Df1tcJ?=
 =?us-ascii?Q?YnTX8+03qp3OYGtNEtH0MZWhZoFccN0NobFjfTLP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea57502-5b81-4413-1b79-08dc96b8346e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:48:27.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgv/CL9XC4k0EKhGSe3qHIYXNEvX0arsZZJkq39NaM6HW9vGnr6IkxgVMbOXoEd7d4DnH2QfpCeEqHMsYQwJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Convert fsl-usb binding doc to yaml format.

Additional change:
- Remove port0 and port1 from required list.
- Use common usb-drd.yaml for dr_mode property
- Keep two difference examples.
- Add interrupts to required property list.
- Remove #address-cells and #size-cells in example.
- Use predefined irq type macro.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- move phy_type after interrupt
- change file name to fsl,usb2.yaml
- remove 'fsl-usb2-dr-v2.2' from standalone compatible list
---
 .../devicetree/bindings/usb/fsl,usb2.yaml     | 95 +++++++++++++++++++
 .../devicetree/bindings/usb/fsl-usb.txt       | 81 ----------------
 2 files changed, 95 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usb2.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/fsl-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/fsl,usb2.yaml b/Documentation/devicetree/bindings/usb/fsl,usb2.yaml
new file mode 100644
index 0000000000000..caedf11db2846
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,usb2.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SOC USB controllers
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The device node for a USB controller that is part of a Freescale
+  SOC is as described in the document "Open Firmware Recommended
+  Practice: Universal Serial Bus" with the following modifications
+  and additions.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl-usb2-mph
+          - fsl-usb2-dr
+      - items:
+          - enum:
+              - fsl-usb2-dr-v2.2
+              - fsl-usb2-dr-v2.5
+          - const: fsl-usb2-dr
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  phy_type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ulpi, serial, utmi, utmi_wide]
+
+  port0:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates port0 is connected for fsl-usb2-mph compatible controllers.
+
+  port1:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates port1 is connected for "fsl-usb2-mph" compatible controllers.
+
+  fsl,invert-drvvbus:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      for MPC5121 USB0 only. Indicates the
+      port power polarity of internal PHY signal DRVVBUS is inverted.
+
+  fsl,invert-pwr-fault:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      for MPC5121 USB0 only. Indicates
+      the PWR_FAULT signal polarity is inverted.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phy_type
+
+allOf:
+  - $ref: usb-drd.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@22000 {
+        compatible = "fsl-usb2-mph";
+        reg = <22000 1000>;
+        interrupts = <27 IRQ_TYPE_EDGE_RISING>;
+        phy_type = "ulpi";
+        port0;
+        port1;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@23000 {
+        compatible = "fsl-usb2-dr";
+        reg = <23000 1000>;
+        interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+        dr_mode = "otg";
+        phy_type = "ulpi";
+    };
diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
deleted file mode 100644
index 0b08b006c5ead..0000000000000
--- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Freescale SOC USB controllers
-
-The device node for a USB controller that is part of a Freescale
-SOC is as described in the document "Open Firmware Recommended
-Practice : Universal Serial Bus" with the following modifications
-and additions :
-
-Required properties :
- - compatible : Should be "fsl-usb2-mph" for multi port host USB
-   controllers, or "fsl-usb2-dr" for dual role USB controllers
-   or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121.
-   Wherever applicable, the IP version of the USB controller should
-   also be mentioned (for eg. fsl-usb2-dr-v2.2 for bsc9132).
- - phy_type : For multi port host USB controllers, should be one of
-   "ulpi", or "serial". For dual role USB controllers, should be
-   one of "ulpi", "utmi", "utmi_wide", or "serial".
- - reg : Offset and length of the register set for the device
- - port0 : boolean; if defined, indicates port0 is connected for
-   fsl-usb2-mph compatible controllers.  Either this property or
-   "port1" (or both) must be defined for "fsl-usb2-mph" compatible
-   controllers.
- - port1 : boolean; if defined, indicates port1 is connected for
-   fsl-usb2-mph compatible controllers.  Either this property or
-   "port0" (or both) must be defined for "fsl-usb2-mph" compatible
-   controllers.
- - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
-   controllers.  Can be "host", "peripheral", or "otg".  Default to
-   "host" if not defined for backward compatibility.
-
-Recommended properties :
- - interrupts : <a b> where a is the interrupt number and b is a
-   field that represents an encoding of the sense and level
-   information for the interrupt.  This should be encoded based on
-   the information in section 2) depending on the type of interrupt
-   controller you have.
-
-Optional properties :
- - fsl,invert-drvvbus : boolean; for MPC5121 USB0 only. Indicates the
-   port power polarity of internal PHY signal DRVVBUS is inverted.
- - fsl,invert-pwr-fault : boolean; for MPC5121 USB0 only. Indicates
-   the PWR_FAULT signal polarity is inverted.
-
-Example multi port host USB controller device node :
-	usb@22000 {
-		compatible = "fsl-usb2-mph";
-		reg = <22000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <27 1>;
-		phy_type = "ulpi";
-		port0;
-		port1;
-	};
-
-Example dual role USB controller device node :
-	usb@23000 {
-		compatible = "fsl-usb2-dr";
-		reg = <23000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <26 1>;
-		dr_mode = "otg";
-		phy = "ulpi";
-	};
-
-Example dual role USB controller device node for MPC5121ADS:
-
-	usb@4000 {
-		compatible = "fsl,mpc5121-usb2-dr";
-		reg = <0x4000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = < &ipic >;
-		interrupts = <44 0x8>;
-		dr_mode = "otg";
-		phy_type = "utmi_wide";
-		fsl,invert-drvvbus;
-		fsl,invert-pwr-fault;
-	};
-- 
2.34.1


