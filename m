Return-Path: <linux-kernel+bounces-238292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EC9247F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C2C1F23F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E431C8FBE;
	Tue,  2 Jul 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="cZJQMZZs"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2063.outbound.protection.outlook.com [40.95.54.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3B2F46;
	Tue,  2 Jul 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947833; cv=fail; b=RPaMdED7N3EK/BEvp/4exqlgV9h5AJMeVHtBz9lTcbIM2DnqaHkfI2+K/y7mIlxJ0zT4fu5JraMSl2/nxqsRWuaKNUbxK5LVgYLw4OwlODdDr6uXxTcI/tBVxc3D0DfTXtrnUfhOGpMiArFMpo7py+34mTixyBnu+2tR2cY/lHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947833; c=relaxed/simple;
	bh=qFqGHgEyyN8yUWr0qjApPEVs20oo7ZhAYqawZjFsLxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMJg3wxPQXdZy2JBjOXjo3a5n4q7eY5/zSoSgzW5dkhqb0/Z08zU3uHCX2dtp5y0Jfeh8TBKYKlJBOlcp80Q370p4Hz780UHscL9uT8VrntTZisXlRSYQhB5WUUcqxIRym85Meqn5vtIRqqu9Ms0ytI2AUKgFlrSxAcGZo3mpAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=cZJQMZZs; arc=fail smtp.client-ip=40.95.54.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrKJxUSPYDGhA+qC61Nu5HXsvhxgaV+YxmnLr9d/yGCXlrl8S6YCAjIsvvYoHdSHLdPK/kMwbWwGCZx+9T8OYujTZfEL0CqtL4SSaaRlGsF/99NrnkT6wMF1K4dp37RrOm5vUypaHjAwsb4kopoI3lyJ2994CFQ40MjlccUh3rFCiqpkR/dUsgkNymhON3s4waAmnNwQ++xpL8P3lgQcElGsH1oonasXqOfScOlQ6SWevsYHOOGuiuhUMQ8up/VjjkzA2B2veClUAsrO3KIzWpYBVcpg4Zmygx5EqTcg4lPEosyervP8Pt+Kv5WhNE5TtH0QC02ybAnF5KNyLxisJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=GVnt/+vgiQ6cGfIssAPc8HMb3ynRPCCI0bqpBHoESqfSMoYd3PtyNWMEm1PIW596ff/pKLpBkvOKRcVsctzbvbLpW9ZJKRQjKu5sb50PziubGWiAeoWjj9XlvZ8b91xegY0+qEacnIXltHMKHbEyBgPaACS6BRfwwOrVzdMnoOhR7g1ojqPNZcRcjo/QMc77Ji8rDlyqlTq33nYbgwAQCzX9ilzOPq1hxsMjMtZpXEsElGnaLZ0tAHAiVwqCJXNQKbXVARqhaJhMEZS6vnZ6k7APLyps5rt04KWyx6Z42uWUY/UENW7S1r5U3uoQSboe7q0bezusixksqT5VeL4RbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=cZJQMZZsrbehAYFGfXmDeO2wyqpIiu+MAfGw5heWyTlm7fmPbZC2ot/IJXh06vMecpS5Ctj2sWcpLS5SpFNy4oit/Z17fEkL/qyFRyAV/VNQRkOtluJmVULMk8D6sChmyTMp8ai6B6A+t8mpS2ENfjDgkybq3mPsnnV4h8YP6ZU=
Received: from SI1PR02CA0026.apcprd02.prod.outlook.com (2603:1096:4:1f4::11)
 by SI6PR03MB8609.apcprd03.prod.outlook.com (2603:1096:4:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 19:17:02 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::4f) by SI1PR02CA0026.outlook.office365.com
 (2603:1096:4:1f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 19:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:17:01 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:16:58 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 03:16:58 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 6681F5F67E;
	Tue,  2 Jul 2024 22:16:57 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 648C8DC0750; Tue,  2 Jul 2024 22:16:57 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v26 1/3] dt-bindings: reset: npcm: add clock properties
Date: Tue, 2 Jul 2024 22:16:48 +0300
Message-ID: <20240702191650.57364-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702191650.57364-1-tmaimon77@gmail.com>
References: <20240702191650.57364-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SI6PR03MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bddf8c-14d9-4a5f-10df-08dc9acb8d19
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|376014|7416014|61400799027|48200799018|82310400026|7093399012|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntDNVrWBizFJX2zd5Pb+aFX53KXFzBNcMBmGcLUBcTvdHeycc/BnuOUal8JA?=
 =?us-ascii?Q?yY5RHV6oSMGR9A3CHOyYe3950pgvsuyRMAyWrTWGHdyRnhaum7HFY5iTFhPq?=
 =?us-ascii?Q?doTEte8aOkAR+02gzb3TylloQ75bXA2AGIFG0SekigWS9NEWD8AFRvFo7zVK?=
 =?us-ascii?Q?A+AYAwCZuS1YyItTIkP+Ermr3SmATdfvQ5opmALXB4uu/wRjw4erDyd/MpRE?=
 =?us-ascii?Q?B5PZQSESaIvOGlkTfQ6KSybYHipVUkyX0K0zZeeh4IkMSrVuEPdNUT+l8ytw?=
 =?us-ascii?Q?4Jc6/qgIph5iFlsy9EWKjY3HupzdOPtZWzGoc3GfPKQRAubzDgNGY5GfWneP?=
 =?us-ascii?Q?RTtWFq9ChKcD4oQAXwpplG0+/4IVTlvjWyAXv8ePMfSUpTDzMboLaXUrHeBX?=
 =?us-ascii?Q?tMzf82QAUDiOndzUVGA59Gydx4cS8sy6DzqtsewAUG0VtK2+mC+cygLymzjt?=
 =?us-ascii?Q?CLR17Rdt/SkNj2YR7aORJApZnof3BBY8vlxk0bu9QGL9UE1+ElZ2L250KZ7k?=
 =?us-ascii?Q?ZJha7hEKoEbchs0bmU9Z08hBeSEipbVI+WIw+qEPyKTAfR8J1spBTYSLJGTY?=
 =?us-ascii?Q?KzopcppKt+mJTRoKKgMnVehfSAWeUiNB5llhNgDVm4V+nUlCN/r/o1Ozn6Fs?=
 =?us-ascii?Q?zNtY125eo+GJ5h4ZGy5IZQCxqZODVQsvOyea1ko+B9KSZxsuZjHsPQ0obrWA?=
 =?us-ascii?Q?NOGHe5anmLXfOQZW+sBNs2j4Ten7Hwf8yOzsiXTBRw3pSmFYCGeHVKjsoQBe?=
 =?us-ascii?Q?VK5ARMrmmnLn18NMmazu5A794xNCd0dqBxiZXdOjhm5E/CSUlRUpdeYF4atq?=
 =?us-ascii?Q?zz/1j0FChYXBJ1/+lRMn1uL3Wt3kwTJjlwyTgc3ShgzKR+eE6dK2uescPBeA?=
 =?us-ascii?Q?/6sxefcMUExQ1b8mvSmJLvNYoB/hNHFl1AkWdpKORQjpeIou7+702Vej8snJ?=
 =?us-ascii?Q?nS+MBqXbgP6EukkuORZkB0krCWh0bXyk6VEdFUpcBeA2b2rLFLd5Sz4bdzwr?=
 =?us-ascii?Q?Mqt7mXjKa39+JWJ6jziGImFRmPguLAcswTAbInNWHxKMF3vsVCgTiEdnsX76?=
 =?us-ascii?Q?RdWHrdesCPj+ePOv7QgMPDDGAa8vRhjv7p1PTt9rR7Tjii5cRUAYGOFRbBDM?=
 =?us-ascii?Q?hQOHfd5hjKi7dZGgMj+0GWrUAomnBC11g3iVY0zHEg/BHZ8YRqQiwmzgw2mn?=
 =?us-ascii?Q?JtgoHuvOMlveUZkwU92HvVSv4mzSoULRjB7XfCkxU7KavscvHL5diIskkyWR?=
 =?us-ascii?Q?ykCtvd2/26d+rMrCPsRNgQc355b3siIRVw/P71rkYdEilGQYWDhRWwkm0zMM?=
 =?us-ascii?Q?PQfsFb9iJakSzRcxAUlx+CL9Bi510Mk51Y1cHGdBwZONqLDFhuA3kJ3bxnEC?=
 =?us-ascii?Q?koirdeFz3h6h4tQh0NE73Do7kUTMyFuEh2x3R20t0e8xRS31xXkvqY0nExpp?=
 =?us-ascii?Q?ppRXnqm/aJdfyJJzDgKwPwTiqCSgZJAzox78fh/MJ6G4YWTQJ8XDONbN+wz+?=
 =?us-ascii?Q?rDi11prtrRh4uGE=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(35950700016)(376014)(7416014)(61400799027)(48200799018)(82310400026)(7093399012)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:17:01.5099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bddf8c-14d9-4a5f-10df-08dc9acb8d19
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8609

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


