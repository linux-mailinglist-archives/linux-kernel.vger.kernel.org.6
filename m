Return-Path: <linux-kernel+bounces-271813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BE945386
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A971F1C23440
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0C14B941;
	Thu,  1 Aug 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="ISwaPs8U"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6363C062;
	Thu,  1 Aug 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541606; cv=fail; b=M62CnLt3JchVQsWR/SMyoBw+h5HcO+Z7UtcONnYnMjjseKjeg7tU42qkP0H/yeLhLt9TYoTwGu2f6eDRvM2duWniWWE72OcTpdOj0GpxKCeTqmhCt1AL2V8l7cL7LsZyZkkEb+EkmohAWEA3m8e2bGmaDf4AqIVToQpYIme/0Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541606; c=relaxed/simple;
	bh=qFqGHgEyyN8yUWr0qjApPEVs20oo7ZhAYqawZjFsLxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNAXQN5HjZzTA1b4PS2QqcVX9US6UqT0FXlEZkvAQaaCD6lTVbTYavMLg60djWgmhD4FhzilqA2m7W0jrShvVAfbRTSbaYlvys5eCUdUpmsG5ioH/+FAHwfl8oO8X7tJ60X19spW8RuPxVTP/O6NfeLXt2VvVSeixaaBovaFFeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=ISwaPs8U; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrIFSXhG2ObA8lDyoozIXS8K28c/8q6FC7fpU8qTPxZCnyAbtgWALVIiQyEnmxTGOH/mqWuiT8d8yxd2NyFmdXj9GYqgUve4saIg+MQOx6dbqC+WNAaZ0gMhkCntNlUiElqtmQmsVuMErwZ3VAsdVNUQsFlmUXmg3P0qqEWi9KayDoo8j4UOp9CuDGX0LVLDccw0NW0ns4pBNZ5DgfR/nTdWLkIN1jijZ894jfc6Ozgv1RAQGC5EYcWtAI1E9KpQVS+MvAwCybmgXFhO1VS0rsJxMFnL+Yto795u6q3FoSgcpUaG89oWj7Q2zzC2USOVMfHX6ucMQGZoGVlsaFtvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=RTCu1SgLTztUKYc+9Kai81gTNX+bjjKOw3WV8GHO143EZVgW74On2q6V8fYLdx7qvuR0OupwnubxkgttNtQ6aK8l4qDcpHKdsXiCAeJUGhPsGwe6lvwGD/P/mSsEmD+3D6/OIbutfvyMb75I4w5R7zIQEOj03gZ3/xXjkgU0AA68lRI6+bJRw0GZQgCL38LLnHCBDUjeAa45Eu04mJyFtmydRaVAygfBj3U3KC1lj2exhOWgSDbntlk7/oCpFZiszdb+bFEpuzyYVQyrvu2JHjmdRcyqSrDGVDFt4E1iNVUhQ/HAZt22/qwA4nwhEJJN3CWlgIV5PDiUDW5Rb7T5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=ISwaPs8Uk0OkXfOXjpGdP+cuCZfaUQVSbfJreX5S/nL/6+nRVJ1rT+dOnSkrJCavrXq/jPJaFJsxSEb+502kJxU/EKK4UiMFYeVGv2fiWisE+ixXEsv7CQS8hH0QIng7r5ZwXTSVnwFgfRZmWc1dXaibYGRqDEUMUxsGtjArhLY=
Received: from SI1PR02CA0019.apcprd02.prod.outlook.com (2603:1096:4:1f4::15)
 by SEYPR03MB7216.apcprd03.prod.outlook.com (2603:1096:101:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 19:46:38 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::f5) by SI1PR02CA0019.outlook.office365.com
 (2603:1096:4:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 19:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:46:36 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 03:46:36 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 03:46:35 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 2 Aug 2024 03:46:35 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id ECD6B5F64C;
	Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id DF08BDC1CEE; Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v27 1/3] dt-bindings: reset: npcm: add clock properties
Date: Thu, 1 Aug 2024 22:46:30 +0300
Message-ID: <20240801194632.742006-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801194632.742006-1-tmaimon77@gmail.com>
References: <20240801194632.742006-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEYPR03MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c26a85-d108-4ad7-34ba-08dcb262a771
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|61400799027|7093399012|35950700016|48200799018|82310400026|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HrYA8mahlmYEqevC+ytWeG1/Chmp51/HT+REcRF3ZV+02xlnrktzOM/70L7Y?=
 =?us-ascii?Q?xfHp/1gDT6LGxq6RlFl/sz2MOkA96SM6JSApsr1RhEivwTt1E45oglQiTkLD?=
 =?us-ascii?Q?tTcNvoe8PM4b28vD+lnnyIIcg5YD/OmOGS2YJJAf3ae5zPZ3Myj5hZiricC9?=
 =?us-ascii?Q?3SDiwpe4l0naOIreTwa4WfTlhhF0M4ODNvsNIn7ODmcCoDbHBice24pKfNmu?=
 =?us-ascii?Q?w7aEL+JslOfegIELbcU4BtTuYD0FHktS3/A8fGClRLyGtxbGUddIGt6mY9Q3?=
 =?us-ascii?Q?t+nc8DS9uylkMSnuK+vxTXMFARaRBlaupZCsuIfaoU2MUShm0VRVCVj3UNQ0?=
 =?us-ascii?Q?RuMifhiZsqbb/jNXIIpTUgTCEizxBEkhoN5mHyXQHnNgGRnvYzKnVheFpST5?=
 =?us-ascii?Q?FJZ2VJQzsvw1PVNRavuC+eTH7KYh1jqTLZz90fmZNRwLcZM+nlNkXp09Ulu8?=
 =?us-ascii?Q?G8jbM9ehXJRJewaNEyZkv1OPMbeJJfl3zvlia/MuZwHw6QU34MtpcPOJgyrU?=
 =?us-ascii?Q?ci6P0SVKcmmo5KUQoWrPJVIKr4M8GUdY/wvVNN5sWTATI6wkv5Lrmq8ToRck?=
 =?us-ascii?Q?tcKXhYDRCz6dq7O2mci6PHtuqrAMcb0msPCVJJJHncCMGxlvrJhQj/OERxLC?=
 =?us-ascii?Q?RCnOm4RMk5VYMmcIV65jwxwxvF4U3QBh3NTOz6XscDwlm6UQOIhyGvyJKAm9?=
 =?us-ascii?Q?KxgY/FZwldzkZVJ8bR/nhsHf8Ogz9W3LXCIWePkg34FpZ5BTCRlDKOuSvgud?=
 =?us-ascii?Q?WDU6ladibxRFc78+vw1ZUKeX/dwgX55xlZNPiO8OMg5cQJZsXgoIo8X8td9K?=
 =?us-ascii?Q?hGIr2mufUuOr/tgm0XWf2Wrij28+il6cxgWXDXHmRDKhZ9F9HqpfpUDEdNUl?=
 =?us-ascii?Q?UAwWXxrZ5v7b1Mg0n1eSSQrPq6t+Lhs0WY4xBzfmA26ywHlDHBkMst5YDPdO?=
 =?us-ascii?Q?NiciN8PtHvN4BEd9b3Qvr2rZ7+7cvjBhRNU4xtB859yV6D9ETXS8iVLZN5a7?=
 =?us-ascii?Q?Wn3P0Qe2MO1ho6JjYgdwXNykpyTlszvuyPkzhq73cCzuH+OdWzv9LeShPw+e?=
 =?us-ascii?Q?F0tP8sHKkn1FHhilDX3Xc7OMP2V9e+ENr9UkMotYNuXkvLLfJLqADD/x73+x?=
 =?us-ascii?Q?9uAvCQXEEbRyKLMv6yYm/UM8ivgFFyq4SbcQ8iUDdpkGEj/6uC4fQkd2WBeI?=
 =?us-ascii?Q?KkbJxzJPjLTBVvkAJv928IpyxIQAyl51xpB1ZyO073xpLfpw7g+1P0GEUMJV?=
 =?us-ascii?Q?10Nk0GhJ/mQLg0E3Hs8UCDk+ghqAQcO3SzvS9THjN4sgSVKLdcik5J5oU9WO?=
 =?us-ascii?Q?wAP/QB6uTVPrrvwN9IId2XVkR+6mQ/Dv7CMNMIQuSP+RMIDgD0mGu4fWrDV9?=
 =?us-ascii?Q?MaWh44SDJfwEteRPU3DR/VJKD/1RbuqktTyVTyyJx1mMBKhQxe1ZPb6KxXrL?=
 =?us-ascii?Q?9zqt758pBop01lBBYBct/evDedQuZBNBX9syKW698GFA+SxHGoMrAv6RyFRp?=
 =?us-ascii?Q?88iPTeFl9nZClmY=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(61400799027)(7093399012)(35950700016)(48200799018)(82310400026)(921020)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:46:36.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c26a85-d108-4ad7-34ba-08dcb262a771
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7216

This commit adds a 25MHz reference clock and clock-cell properties to
the NPCM reset document. The addition is necessitated by the integration
of the NPCM8xx clock auxiliary bus device into the NPCM reset driver.

The inclusion of the NPCM8xx clock properties in the reset document is
crucial as the reset block also serves as a clock provider for the
NPCM8xx clock. This enhancement is intended to facilitate the use of the
NPCM8xx clock driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/nuvoton,npcm750-reset.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
index d82e65e37cc0..72523f1bbc18 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
@@ -21,6 +21,13 @@ properties:
   '#reset-cells':
     const: 2
 
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: specify external 25MHz reference clock.
+
   nuvoton,sysgcr:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: a phandle to access GCR registers.
@@ -39,6 +46,17 @@ required:
   - '#reset-cells'
   - nuvoton,sysgcr
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nuvoton,npcm845-reset
+then:
+  required:
+    - '#clock-cells'
+    - clocks
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


