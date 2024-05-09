Return-Path: <linux-kernel+bounces-175184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024F8C1BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75841F21ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF468E;
	Fri, 10 May 2024 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="m4IsL/rt"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2078.outbound.protection.outlook.com [40.95.54.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC8B64E;
	Fri, 10 May 2024 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302636; cv=fail; b=GsLeDme1DveL1HoKNS6WDXAdvv70PLl63mTlhXrq8steC8rS0sZ95WwSjXx6RL91ZU4D8jE7JzRaoJPCedm3q6EGKTDKx/oVaHh77PjlPU7uDObvYGKoxfoAhEE1BCF8AxT2ndW2e2iEKE6KZhURRC5tL/MZQYnwYGI7b4m+wD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302636; c=relaxed/simple;
	bh=SkdF342MSDV52iyq1of2MtkfwfmArsqJ2RVqcDgH3Y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G23jAWjOoFf/CowlrzvlSiK9c4HRxht2V0N6/jaJSmRohZ16tt0exl4hsabYEN40AbeNIyZ/LO0zd6cfilD+wjV4hRCV0WJ4R/9cX8FFmXAJ2HjO2cnh3SX+2z4Dr20t/osWemw3GHlw89X87SjATYPp2NZwUcdBsPoKC0Rt+Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=m4IsL/rt; arc=fail smtp.client-ip=40.95.54.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRMiDoV5S5dTrPpvABBQKRLwhAkX2wMtred/ar5ZbjGIZa6VrliIL6SLvgh84/VZAlVlPS7rtqFrvfQP+b8p34PMYxxIFcOmPKJmaJI7bcg9m4wtsBa8Gi096JQB9wUq/jDDhJbd2L+dA5Zv09Mx6EtX+QvTKEqdP93GRyt0Cp/TODadiWs+PAPZBmQ2HWJzb70/aAlwv10NYmSZe3Mpg5nERkXXGz35Wjlsae4VaI+o3xL7wVwu2maZZeDNHq/2fMnh36E1of+FWIIYD4xVoy+KWvhuiUlb8tILGLs52uXU0KlnMouGbOPBMFRGYyZDawlHOhSIoCSskcO2HGet6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kll1jnDgC8UqNW1en5+WDEEQHOk9Mo+Og2ra2fjhu/U=;
 b=OXmfEOr1qTLUqsFlhySCNtmZRSwDkWi1zMfaad4wx+Xl7cbEFcLqMtf7k+7edzc9KPijjuLPznRSWY4/1BdwOtu1D3kT2IO3EhI2+PvXjQ3cdZ/LYs91nQPkulOT1+Co0E/yZSXff4WgsQYNMX9iKYaZGhkzv0SOT7YuKMcJsUwDUX1He/VQ0A67ynhopouylkoobMO4UgB0p1LYhXg35m88FxYsBRO9QCnjgvdbkmLLMoWsXUCsFR9uayLczOHm8Y9KSwwMxcptFMk+FAdNsAjYXJkWNFis4czMSRfox/ygTLQV0oLR9D8lTXnCegbGeQOGEtVVMo7ETErpm57FTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kll1jnDgC8UqNW1en5+WDEEQHOk9Mo+Og2ra2fjhu/U=;
 b=m4IsL/rtm2orq4wZmxnSUlxwkbV+88/lboSrj7SE/ADJBstG3s36w/ky2sy6M1QWFY2RpDHhKIvE0wuRdewLdfdAAs12ym2djI1Ixzc4DcqlxsEm+cxDb8MeQxk+1JKyQVjc3bKupJVdaogP2p6BJNErnhmIi4/KC8IhIUtKrwY=
Received: from SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7) by
 KL1PR03MB8897.apcprd03.prod.outlook.com (2603:1096:820:144::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.13; Thu, 9 May
 2024 19:24:17 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::ff) by SI2P153CA0001.outlook.office365.com
 (2603:1096:4:140::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.12 via Frontend
 Transport; Thu, 9 May 2024 19:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:24:16 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 10 May
 2024 03:24:14 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 10 May
 2024 03:24:14 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 May 2024 03:24:13 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 1F82B5F66C;
	Thu,  9 May 2024 22:24:13 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 1DE5ADC0BCE; Thu,  9 May 2024 22:24:13 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v24 1/4] dt-bindings: reset: npcm: add clock properties
Date: Thu, 9 May 2024 22:24:08 +0300
Message-ID: <20240509192411.2432066-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509192411.2432066-1-tmaimon77@gmail.com>
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR03MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b0bfa0-156d-4ffa-3b3c-08dc705d9dd9
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|35950700004|7093399003|82310400017|7416005|61400799018|48200799009|921011|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BfNsKpXUYhHNcnnLYzjPaTlCrjL78yaTR23wjVjedLGP9+RRD93oqT4r/y3?=
 =?us-ascii?Q?Ds/8IlFw7ineFJ/WkIVrijfzb93yq6tP9u8SVxHwP/LlKi4d7xE0TeIVPHXV?=
 =?us-ascii?Q?Mow5DcZH+2uoAVKH+pv8rCNFJz5w8mrRHR1An1JfV22SSyhwkwi6uhSGQ769?=
 =?us-ascii?Q?cv7vyGJ48fz+z/JV0ZH3fKKXmqsHhuJM/rT2CifhmsDhiUIL74vgm4+aqI8P?=
 =?us-ascii?Q?sA2z0v30lUtaE/4plspciGzIwFt9HZ5pPTCq4l0ZgbonZ8qhUoCI5HbZbzwV?=
 =?us-ascii?Q?Lueoy+iVVZVGX4F2jKKqO/2hy2XSaleDtzeHEBHajVbuuP7X8D8E6hIQ4PvZ?=
 =?us-ascii?Q?AsIjsdE1pSjWs6tcbVBRgbM15PKsFy5EUbg+Ami0EAPu+mTAJAlfKXrIbJPz?=
 =?us-ascii?Q?v8JMFkWtQd5HGpwZKe2r1zob35DGRjK1nlsCDR4ASNk3Vn8B+yoP2hYlVGfO?=
 =?us-ascii?Q?L5XYNt39ViqiKn4WGBP2Y/FrA1XAu+q9bCzekEhS0HBAC5WdhxRoNwCku/PR?=
 =?us-ascii?Q?sp0Lm5cCM6aJd4o5tmFZNH59+fcSxQJQV3o6AGuW66CHY9tr7z1IMXEqOI5w?=
 =?us-ascii?Q?CAVsG4IlTe1IiCLeg7iIWliOEJmT+ouAaLBjpeuVSvD1v5MH6drZogN22Sdp?=
 =?us-ascii?Q?i25I+eaRRHAVL07D43qYTZdlQrI0opBnhT0TeT3rN8amBk/cg+JuhgN/M78X?=
 =?us-ascii?Q?8PX3nCvMWcqPlP7fJUYbd/bnYY186Dk8/XE/feV+KDAJ8QCp7PiUQUJpTj8I?=
 =?us-ascii?Q?Gn5qBmmg6JWJNtjMsMRezlHaqM0vE8j64WY/FSUIv3qYEubPt3hW+UtsGUr1?=
 =?us-ascii?Q?rMDCV0C7Xcfldpg9FUU2vq3ZT3k+bJgWwShFcFP09Ur6dQJ7IYfqs4UkvWpb?=
 =?us-ascii?Q?gPMMLuysa9wieG/GHP9LI4Iw5ySWDdvy7hwaylzp3Zy9eknRrHip2+kCEptB?=
 =?us-ascii?Q?HOIbjOaKPsCT36OWBrhQUzM9mXXMOOCZaWH5IXj9AeJkTxstnBfO4+msgH8T?=
 =?us-ascii?Q?0Kwsjqus0yk/zB9m0bAsGv0oF4JHo1rRp8u8vzaexMywf2NSpsN2EpGQUK3p?=
 =?us-ascii?Q?gc2s1tRn6lnQNsHAiDcASmGvxC3n7clL0luhTNid7nf3c3zJgh9Xv29V3/Ai?=
 =?us-ascii?Q?wKc0loAcsxUZ3jU1aC0Px6xaIVn29wlJk2h2aYhFnb68OMygqSFEPwtdDwcC?=
 =?us-ascii?Q?sE7KpikpwY8XBsCIFIQG7bMWgfxndkc6BW2XUNrlHnzX/2abyJc5xbncO0ee?=
 =?us-ascii?Q?Qnse57TgqpEfcNSwVNB8U1BpnWgXEoosX49s20MCtMqjE0uGMrzP7HboYgDj?=
 =?us-ascii?Q?InwafR+l7ya9PgE3ChFdYMzbnb+Iy5MpGgtSrpZTUs6M7pe2rSZqhBrfG72U?=
 =?us-ascii?Q?praW8xoA0JFFIX9if4STvlZjzAmrvX/N9GDolralGXElY9v/ePBCDDuGuEx8?=
 =?us-ascii?Q?3/+viIFVmJ8O2v5k5inFNVM1P7tgSQjs?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(376005)(35950700004)(7093399003)(82310400017)(7416005)(61400799018)(48200799009)(921011)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:24:16.1359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b0bfa0-156d-4ffa-3b3c-08dc705d9dd9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8897

Adding 25MHz reference clock and clock-cell properties to NPCM reset
document due to the registration of the npcm8xx clock auxiliary bus device
in the NPCM reset driver

The NPCM8xx clock auxiliary bus device has been registered in the NPCM
reset driver because the reset and the clock share the same register
region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/reset/nuvoton,npcm750-reset.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
index d82e65e37cc0..18db4de13098 100644
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
+      - description: specify external 25MHz referance clock.
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


