Return-Path: <linux-kernel+bounces-288152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D3953685
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375431C25363
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765591A7060;
	Thu, 15 Aug 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="F3GTik2R"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazrln10220003.outbound.protection.outlook.com [52.103.192.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259E19DF9C;
	Thu, 15 Aug 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.192.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734190; cv=fail; b=bo8z6W7gRuhCeDLNPo51ODcRWZVSUMSKRcC8MoaMGeYM5EY3u1KzCbq7Rn3AX5pZZz23eJj+ftN8q8pg0D6OH3ccbGIKBEFFjMUCkGfuo4Awjf476Rt/O9AkkF4NYiH6qeT8HPS1G5Xoga3Ot7hBKE4PcG+aCdKD65YIPr4uD2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734190; c=relaxed/simple;
	bh=qFqGHgEyyN8yUWr0qjApPEVs20oo7ZhAYqawZjFsLxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQfj6LT1YSMMvVIWSeBM6UNJhUz6hMy//9+wlqH9g8pyHSQG9mnOtnUNehQKa7VH2GAJPlcTbJ62vZd21X100/tEPnW3+QkLOih8aV6OaONK+aU74YkiDF0s60/pV5kJItDFGzvD/bwy9yGMLewPORx0tNv/g3Q4EZfYpjkkfjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=F3GTik2R; arc=fail smtp.client-ip=52.103.192.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDukfJqHYzgizyw3CgHpV+INeVo2lKtjgzKj9YdTbB8DeShkrvJZwB62R/sElBNCezJMvMnCMPIuloXhCWq0f/JvZuJ6FHPpC1RqnFmt04649PbkvAGmKLTQ6FFLK/lC+oCA/Kew1QuId/eKDCD3ljCzfVYoD3BuGJaxocBm72U+hPIwEVbgpUbIqaxjI3oWGE8wpKVKqHiVprEr0PK3vMpKrdTIXRkzNNRXRvdZwZ8pKaG+f2O4+4baYzlmtP/qblQSVhcfh03tIlYEUb1cgo/04Q3/h3JSLj5UH2PPjJlac7tQUhY27out1ZuugREhNeFnTKn/PEAd24Z1vUOXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=xpMno/XlMlpoPqhFq+CsqUtVGqaF/5OaF3eAtcwv61Ivmls+h19EN1rFHThG8wkt2374QRu8VJtkme89POdZlY7zx+Bo04Jh7Us0/ojbwM/a1mPJD9PDGcseSmJsgbXdXVcp30YNcw4ymHohrnxTDzBGFT6/Zbjf5C3vy0JOhYkY0BqUYMeQY9kmabqdr3/16PC4t+8/fHl9RhX1grk15MNuKBDpG38MoryGG0MvLbljRfK43trc/lqZJnZeADE/XCbk2NqsfXhQ0qVkG7S8Cs3F0vFgVgZYzzg642VVU0G+bSSmy1pAKTdppknc0b9MA/VX1qpJZBaB02ngoLnG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=F3GTik2Rmi3fqq9fZzjPC1ro6qD4j6u1i+TD6e72G4XeTxrXPpX1RErsDwJ1vAMCBHuby4vSI7Ice5M2KdSJEO2/CdaW35K5gJUcw5LLTcy0ATebii35DtaRxqlynO8T+MKHk4tHVHK1voUflMP5y9QBAfYffVK/eoMNcVn5ToU=
Received: from SG2PR02CA0063.apcprd02.prod.outlook.com (2603:1096:4:54::27) by
 JH0PR03MB7445.apcprd03.prod.outlook.com (2603:1096:990:19::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.18; Thu, 15 Aug 2024 15:03:02 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::ce) by SG2PR02CA0063.outlook.office365.com
 (2603:1096:4:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 15:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 15:03:00 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 23:02:58 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 23:02:58 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 3EAB95F5FC;
	Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 2FE8FDC0B61; Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v27 1/3] dt-bindings: reset: npcm: add clock properties
Date: Thu, 15 Aug 2024 18:02:53 +0300
Message-ID: <20240815150255.3996258-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815150255.3996258-1-tmaimon77@gmail.com>
References: <20240815150255.3996258-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|JH0PR03MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: e098c9f2-d4e3-45e3-b7ac-08dcbd3b5b14
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|61400799027|7093399012|35950700016|82310400026|7416014|376014|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcQxgzJohxY11y/LbvLZKZtJExDFeC4ajWPbZN3T80ZZpsnVJiqlVQnY7VAA?=
 =?us-ascii?Q?bFFUOIkx0v/Z8ZsKRRCLpkx/ygkc0iozHEtHLINi3QTlBW3NX/3irIbtteWA?=
 =?us-ascii?Q?WJPZVH4/t9Cb75109/jn/IXduqzuWMR+Vh4WfLBF1wHrox8pkFl2zAHnw/jt?=
 =?us-ascii?Q?2ZiBUWRR/XHVN+y9uILyliAjzv9Nbwruqv1V3fnvsIUnbC/HIAL57FIYCVbB?=
 =?us-ascii?Q?oo9nk8G5Xh+4G7XGorPx4bRlJONNUtQaxb2IZtQTpmbrqHc7JGUalKTMkajv?=
 =?us-ascii?Q?H+7U8siWN3cSgwzAiMil6yxHhrz3xUliD59uMTtK8qFE0/SU6zDUGW9cIK8H?=
 =?us-ascii?Q?YTA8o781GDor5bbWZVn0unZb22U48vT4jZsFhc0kgyBNyBcr7iksiQZUTB6r?=
 =?us-ascii?Q?WfXYUrs7Td5kL0HtLHNmVTDwKTj/OV/xWakPiliHvKShhRnlrYOe8Fh8WKJE?=
 =?us-ascii?Q?asTtXPIHpQpeSsUklb8kQ5w8/JqS3mIXzxAm1NBQgYsYOtF9Nq9tIiywtQSe?=
 =?us-ascii?Q?uEf03ekqwHGOdNOzZ1MubKSXQNRw6vZXQ2vSglLLS9cpmr/htjgjUOOJqvkp?=
 =?us-ascii?Q?V2cg1EjCRfWLx8EPUFP+m99N5kmKhCi6rjW6iDQSZCAFG4JzOwNU5vKz371E?=
 =?us-ascii?Q?LKAt/3t1NheQ9vhX3lNFADo7U6FaNFX0IupdQzkqBcWk5q2V7OFa9HNQPoNF?=
 =?us-ascii?Q?+vWRsrEQv2cRAcfrQSbAA0R+uamlOafjjx82uvgik1jGRF6Z5bfNmb76YN/s?=
 =?us-ascii?Q?+lvKCyzQEIe49NGofY6PyAbsX97OXiiNLWfSC81cMnJiT+vZVrxuoxwV5fxq?=
 =?us-ascii?Q?irSfc8R1RmIF8mYHLZM8hX2VGQxswqswYHJMi4ReT7i3vaWlaeYonXm6Mhup?=
 =?us-ascii?Q?TLerK/7f50LX1T1lJz3w5xX0VPEtxuw3upEvzPxoOnOKEFc7QZckU+Qr4sk0?=
 =?us-ascii?Q?ArkAiNpq+4eBtVVO49rLsG08m+uORMog+OyWmXqwQSkSyQVGG002+MweoXSw?=
 =?us-ascii?Q?JffRCVAMNHVMA7F/10B96e0xgT3gMOjgvpN6ptMLnusPSkIKR4Lgm+KuoVxK?=
 =?us-ascii?Q?9jfCP/xIfoSb9Se20kMuY9cwvsTYIW47uJGITxu8+Ux820QB5zJg25Wvs6lB?=
 =?us-ascii?Q?4IObpcBuEF1isW3u/DG9eeYFym1yyC5olR6rsc6/hisLppi7vR9i2oLxukG6?=
 =?us-ascii?Q?if0ZlyBuFBeVxiaI0imwrsRf4+RLGpcC3ofxfVjhOV8qdUR9WZ22LLxMSpHU?=
 =?us-ascii?Q?r/4pIRx8BXy/+NhIc6LJ7kN2O8LE9ePsK4jD7LO1bF1KouI05sT432xOpzp9?=
 =?us-ascii?Q?Iy2qlKxox+A7F0X93i5Kdsw0k58S2sOOYWRP4+tRB/Znp90Up34i1mv9Esae?=
 =?us-ascii?Q?T2hIVZnEtLGHWzjZrQy+9ArNd24uIrGMj14n/RMxPvdG89G+mfa+YaBLXzPA?=
 =?us-ascii?Q?RN9pKzqXGR1+Myt2Q1aGhVNYp1wYNGbAbRUgfT8EE6V5OkDBAndkXhOS3Aqa?=
 =?us-ascii?Q?zCSSaFFdviPgBKA=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(48200799018)(61400799027)(7093399012)(35950700016)(82310400026)(7416014)(376014)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:03:00.8103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e098c9f2-d4e3-45e3-b7ac-08dcbd3b5b14
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7445

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


