Return-Path: <linux-kernel+bounces-220064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033390DC45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFAB1C22D68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1515EFB3;
	Tue, 18 Jun 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="oxHPn7iR"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2087.outbound.protection.outlook.com [40.95.110.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E1BF50;
	Tue, 18 Jun 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.110.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738074; cv=fail; b=Mp5/F9FecGDPIZAhbMAqYFxm/67T3e1OpYiz4ldVCqAJ/cNBFq0HfS45dPBr3EHxEo1A4eisIKiBg70Ka98NvgMOHBhn8xpJ5uOMJFQ3vEHB3LWDyO0DwEmefoK67mq1VFZERgyNF+Bb6BNcRnLsXDpi9Z+yoFfgW8MO2GkQ6cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738074; c=relaxed/simple;
	bh=5l3pdLD6j41SvSPIj9SqQ8Fhb6SyyRws9o7de6nqEvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeIvXa0nGuERhxkImJX5mhhu5XtD58b87LXngH5xQ8Yi9jTntj/Kw9pRpst7ffwvHN4wbCg/ZDUWogaxVn1GhjfH8A1wpIQ7S72p552Fo2MNLRyg0s0vW7eFP7/ZvVE/Xq1tIQOKqY1LQ+RLbbr4IBQnj2PpHWjWgVZsn5yc5Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=oxHPn7iR; arc=fail smtp.client-ip=40.95.110.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF1j/DOebL14HJysyRPOPd9OMO5MU9L/+cUoSgUjsxgON0vB++sgD5YSjfAoZ5eNbiYESawBm0ekxWaZ2341wilqMGozTvGZvIgeRH8fU/9kxw/TyNDZ4qsuefSIHA4jSxp7C3O/iuABZstnUMzXazUUEiPf3OoSY+0kH3t4isgubnCfk+76Qf5sXlSy0ovxPetm5c8JdNY5pFrRkGIHofXP0215z1PU9Dvm4uHMnWoRePdE4Kzlujs3318eoOoKJ+vRxvQGyrdPI7Esq72cT9Pr91oka/DCxYD3Au9mxzPEGH5V4dd7SXBO32w7XKW9EUwkV5mbOqg2HYrj7cHwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt1m6WJbUfu9UFYVa/YU4Ed38FbBGZnxRO2M1Aak2t4=;
 b=B067XVG9cKbk5VEZiwdCgBPzCtCnlRCvRxpAt5DedYQIYLrfvUSfOVuTLGiw4ukT8umfA7K020rP3UBkJ7h281F4L6FxxlLiUe30L6HM4dRwnOQmPeW+/woQ1deo9kjNmTYAKs/6kP0IG8U5Sn5mUkIzSnm0Z789gDObgOU+iJDB0nXOjieqBsEwAeXVTxmEMCPaa+xq+fVSV5qnHhGjmOdn44FjHgSE5DQYsB4aF22JboOIs7X/m3fhyjuezrnxkNnEzKIqEwvB2KHVPVWj04S4zT+5txdeTTvmUDp86i5STu7+pB04rA9i3bP7A2V2LiiLtDfK6TtD5svt6fLwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt1m6WJbUfu9UFYVa/YU4Ed38FbBGZnxRO2M1Aak2t4=;
 b=oxHPn7iRCmsg2yYso1bgS1SDUO2OYrS8j9pyEryksdQe4620Ao/+Wg0bf2qI155qz8r0nGpd/ViYOdC+HTo5J84E0IFPRxUiQWFCSTEHRIzuQBSuoHrJ6Gv/S43I/0NvSTr7F7ntWpP5LG+1b803LFRDtx+JqCTvhW1P7OpzLyY=
Received: from KL1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:820::19) by KL1PR03MB8822.apcprd03.prod.outlook.com
 (2603:1096:820:144::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:58:26 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:820:0:cafe::3e) by KL1PR01CA0007.outlook.office365.com
 (2603:1096:820::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 18:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 18:58:24 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:58:23 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:58:23 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:58:23 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 87C465F633;
	Tue, 18 Jun 2024 21:58:22 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 833FBDC0726; Tue, 18 Jun 2024 21:58:22 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
Date: Tue, 18 Jun 2024 21:58:17 +0300
Message-ID: <20240618185819.2155595-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618185819.2155595-1-tmaimon77@gmail.com>
References: <20240618185819.2155595-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|KL1PR03MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd16319-27f4-4123-a73b-08dc8fc8a162
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|35950700013|48200799015|7416011|376011|7093399009|82310400023|61400799024|921017|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QegjpYsomvDfUg2woPe25HvDoG6l1gfykYN7jlY3feKWNJXHBATSEeG2Ztnb?=
 =?us-ascii?Q?vCOBq1ibVEa0jPw1ZYwZCT0a1mipSie8nhvaXGnruMg5Yh/2CGVVq2HTQDNt?=
 =?us-ascii?Q?HUfHhp7HEed8C6mkjLRGuelZsYvaTyGzNnmM+k3pHgE+LhMzV26jTNu/3d4A?=
 =?us-ascii?Q?CVFH1H/Wb7y+/nlrzOsJQhHnvVYMx8+U9/AvcutuodjDqLblHztjJgsT+9F5?=
 =?us-ascii?Q?OTNAjauWVFa7RiDf92bxUaY7YODTXiT9SeVlk+tUZZeNxweHsMN3qScUQgkZ?=
 =?us-ascii?Q?DPhuow5mCGkmCdGSodvyikVKV3Uo0Xeguc1FA6YvMxP6lyg0xqtjosDIBC9T?=
 =?us-ascii?Q?aFs+d4UGcC43c+9IOtbo8ECDvPwi0L/vtFyYAxqinwA6plsolP616e9QY6M+?=
 =?us-ascii?Q?t5RCj+UI/HHk3uJ44E0kXLbDOwYwuRTpE8+8MOTFDw81tdPBhwsXozeJenr7?=
 =?us-ascii?Q?9C4fB8OwQCA4iXA0lTqzUvaqN2ad1vJuV3vJhVFH2Nwx8BxT4P7xRzpR6fl5?=
 =?us-ascii?Q?OpEXyyPVKgQ+wRU1jlTLachjh+x+F/dREgnb5eMuMuZIwbiShKzGZJF/OzFD?=
 =?us-ascii?Q?77bTLRjKguxfq6TscjV2ANg/YYAXmqwojARm3i9p1yIrKts/m8AJGNm7JMXN?=
 =?us-ascii?Q?8ZJCssn4EHDsEjKw9VqngsPu0H1hxyM+33RV5ol6XqrLB1I/15OlbxoGTwsn?=
 =?us-ascii?Q?69On8OEyYRd76E3jvcKDoFf89auP+0R3P+VzNJTeiWZZdsQb4k789AmnhsUI?=
 =?us-ascii?Q?qxcmS0E6cDFMaUmQ5G5bqZjbKpNALHGQvrWsQjICqUwsDHJaVYGecTx/Q+NC?=
 =?us-ascii?Q?O6F3POCDWjfh/7VJJBjf+lrUqS7n2HaLnom3cEYoVB9QwyuayMmG9SmA9XWF?=
 =?us-ascii?Q?zsaUcDW1lX3j7vZ/GRY3Pr4+OzGr5k/wghBmWuUSZEqlHoVQIbnWQcrSW8eq?=
 =?us-ascii?Q?RKL51Z51mbQzKtVKqDeqQNrpHPi4nnV+38mRh/lrfoidhjTzkMew5P4Obq9t?=
 =?us-ascii?Q?R0v/UusAh7WZSnnhuFx6cmMqwVrjX3AynC9mrR6eULcpZo6JTN11BhTILcmL?=
 =?us-ascii?Q?ko7Q1OyCuXLjzUj3geVehgLHv377x3zK7IkNfJUrXZxUSau+IDX6N64M+ueo?=
 =?us-ascii?Q?uIq830TF3/vhgbW4V/RWIUg9AmXj7OGu0mpB4hBqhRLkcLPcAN85okd8vilg?=
 =?us-ascii?Q?8ZopF5Uo0dPOcBYHOh2q9voMn6nB/4ZBOLZuoOPlfQ8BhEscZPMDWDcoUQcE?=
 =?us-ascii?Q?RvH9yYxdmjACNcX6+nIvQU8BjNEQlv+w00ELlGGdveXWCs0TBQFDHl8o4RtX?=
 =?us-ascii?Q?9zO/Xwsv77+iGpuQaeoHLGv6dMZWPJNFk8KbS/GVWkZZYRG2Wco5Tdeb1ksd?=
 =?us-ascii?Q?pU8QpvTSohAC0NSswUL1VJTA5f+HpUMYxayDtC4q1sjDnscCQ4lxL3kiEZyd?=
 =?us-ascii?Q?vMMDsWaSnlCBmS2UBoRwZjv/etEd8jZb?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230037)(35950700013)(48200799015)(7416011)(376011)(7093399009)(82310400023)(61400799024)(921017)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:58:24.3127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd16319-27f4-4123-a73b-08dc8fc8a162
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8822

This commit adds a 25MHz reference clock and clock-cell properties to
the NPCM reset document. The addition is necessitated by the integration
of the NPCM8xx clock auxiliary bus device into the NPCM reset driver.

The inclusion of the NPCM8xx clock properties in the reset document is
crucial as the reset block also serves as a clock provider for the
NPCM8xx clock. This enhancement is intended to facilitate the use of the
NPCM8xx clock driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
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


