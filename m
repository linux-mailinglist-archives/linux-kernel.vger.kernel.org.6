Return-Path: <linux-kernel+bounces-174819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26C8C1567
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F10E282108
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EC17FBCF;
	Thu,  9 May 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="rKEBpC/4"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazrln10220000.outbound.protection.outlook.com [52.103.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867F3D3AC;
	Thu,  9 May 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282665; cv=fail; b=BFp3NlCmIknBIqIXYc6mZN6qDQ5A28ANv26vcakncPnCRNSbPX7CQTtD/npwCfExcigf7qUOS2EVYUP51zqw+tlt568luWVko7Lmx1xxb5++P3UuN25x2Gt+yRlZ6woyRaFKvosht5dBpONlmKt51B599rAIJ0rt2+E4oQKQoDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282665; c=relaxed/simple;
	bh=fBawpr2ty/iW2H9YZNwZ6uahwYYar/1q0tsrEPr2s5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOWPqUMiWuLrsL9AIyIpgMn6TBUFVOqUSOloqKjmKfyqo2Gr6MpVfQDXPw5bSveGeDMPZbGJM/rJSTgQxRg+uV5o3Y3QTLrFIVcrAsFzSeX81p7uxhxBAGqxkld1sVZlqqs7Y1L3lWjjqJ627/mKaWDRUZshq+b3UOWMzz6MNLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=rKEBpC/4; arc=fail smtp.client-ip=52.103.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLv4ejr3oRAWcQxMiOtmWpSeKmwDuBnMVqvL/ZBnYPgkEp1pWeErQFhg5uC6/tyMuyHWPkdEsFIA35ZpmzOipwtAvzUMQDbxgweGPyHxn7WcFa6Q/ktCnrsPqpx+s7G6cvWQ1CELigNOy+K90AXMMdCozTuX7g6EskMh6Ep/8C8CtpVRBzhpSmk+dMElsfLs+0BxudvNwwAVyUFq+npLyxKRMMWLTzo9KWVbbbgUyvSPOsZvkAacM8r9vfhdIlmgWUDQzPWHqrweM60xYuj81dDGmKm0q2BlPRk5U/Y2xxYlwtU5I9r152C3C+lCNCSGkOonl8kubpeXE84xWtygUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrk5lnNE+YHeysnxbdGlrXsCv2zMIwxk/zuRUEsea9w=;
 b=Bmus8B/f8l225jE3qjtRwRy2Fbi/skUDk0JG6ZFI1/0HHjGCgzdFlpmyfiTuzcPIpbF+nsJ3CAfeOfI3QJJjj03oZFBUe7aDgvffysxLctSJ2ZQNCr3fSTSt9Q2kYcFwHRTkH2/I1thhamOT0iV9SRnqluWF5u3xHOWBts6szypkO526iP/hVGwW06U4N7Dolyo6ZyfDlE/zY16DjjTG2cKiZ0Xsr4+e5Rjtt2jy3BCOeB8nXB1bNwHWE1Nq2Zrl2C3+fHnG6/jsgN3fMDrukB/IvK2vobjv1hSk7xOuxfWDJMawK9nVQyYuXda93nn99A+ncolmmL4dVurdehQngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrk5lnNE+YHeysnxbdGlrXsCv2zMIwxk/zuRUEsea9w=;
 b=rKEBpC/4iBRyZ7srQx0z/feb3D6G+Oa+vhlVM/UyPI+Ds0MouVuFBzgW640zuMF93zRR7s0cEI3gOrOYXMRBAactOXPK8uG7q/fWVp/0RM7ueOCVKl4dvYqR1nDwEEorlCnOoJm30qLN1s/1ZZXNEE4RnquGPODW/F1xKYfXNvE=
Received: from KL1PR01CA0080.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::20) by JH0PR03MB7981.apcprd03.prod.outlook.com
 (2603:1096:990:31::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 19:24:19 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::87) by KL1PR01CA0080.outlook.office365.com
 (2603:1096:820:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Thu, 9 May 2024 19:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:24:18 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 May
 2024 03:24:16 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 May 2024 03:24:15 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 30DD25F66B;
	Thu,  9 May 2024 22:24:15 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 2EEABDC0BCE; Thu,  9 May 2024 22:24:15 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v24 4/4] dt-binding: clock: remove nuvoton npcm845-clk bindings
Date: Thu, 9 May 2024 22:24:11 +0300
Message-ID: <20240509192411.2432066-5-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR03MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0385bf-a251-4c43-7db0-08dc705d9ef3
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|48200799009|82310400017|376005|7093399003|35950700004|61400799018|921011|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UU9hoOZvxpTZOTEKTYw3Z1Cpj3CziiL4eHD4WM+m5RwoH8LdGibc4/BG59Wo?=
 =?us-ascii?Q?JsxZ2BQ/j61DtkxBuimpdsjrcix28L9Ghowgcr3CtnXY/MTaDRtHQfn97UvV?=
 =?us-ascii?Q?4LfeITGkZm89/rskfdtd3sSCUOZqSb3fpXpDXIiJic3w99+TxiBX+w50gAHH?=
 =?us-ascii?Q?a4YkfZ/nSJ1bB8IvkGempB/2woQvwz8gNFrhynxaGvMhQGnXEZ1v2yaoFG3w?=
 =?us-ascii?Q?x+b/+IReLKHWlvSikCL1sNUGMmKeit9d3GZfG/hD9C1BnHz2W2Fd39EwbVG8?=
 =?us-ascii?Q?C9QSCf3KdnjcHlomaYcmnDDGf7cU65jvmNzg/qNLyN16R92LKvZ4l/XxX6Qf?=
 =?us-ascii?Q?Tj/IbaEVMRs90HUbZYZCKca937l1FRD8wJ7hb7HenVaSgcvdEd4Az66u9orG?=
 =?us-ascii?Q?vPUD1h+mrnnui/10BlWLdqFZgYxACjrOl70fEXfGfW1uEwPHXyvrRbj0WDpZ?=
 =?us-ascii?Q?wPD703sic0tSRt61mN1q5qxbV9z40XVyxvvnv16+r4FCDwmPDoNv8A8H7Ixp?=
 =?us-ascii?Q?YLcDRvfZ4IVDSAyEY+jben+s2jqpK9jCbSPoAXlM1ELgbALrWjTmfVbyJQnT?=
 =?us-ascii?Q?jH72VdwhOuCCWlcN2PJ5EI3MT/49zeyzRnaVfjqqYHi4gkgf6xeE9cgsFEEb?=
 =?us-ascii?Q?AKgVQqgB7nRzxpXwrxxVhKWnUT6QqlMhz/ShI4zChs4RKXHobKJx/XWKy++6?=
 =?us-ascii?Q?t8YMfPp6U4TJCTFEVUc7NCbEbXnlAruheRtLC3QxLmer8xWrfAt12mMQ7cAO?=
 =?us-ascii?Q?SyRYCeaLUfhyIZDiDvZ+hIT9GcvmHhLAMNgvpkh7ajlnd9optGn2tVcvBqb0?=
 =?us-ascii?Q?PAIlzbfpBb1yZ0YUW+XwBgT6LcmoBRBT05bMFMauumBP+Jhb5f6fsM2yemym?=
 =?us-ascii?Q?BBBdKITaJng1+BOv5MkyWy4Ag170qMN/pG7Av/7yQ/hjQUaaABciIbNsse0h?=
 =?us-ascii?Q?K/1YRE/+jFzJwtLeaRkdJMQwsr4cBM5sj2LhzWko3AP0ZKYzm+ckt0uw4q//?=
 =?us-ascii?Q?/3jTLC1Pbq0gEOkgvD6gtBA0MNWTBkLC9P/9VkBgBB3A0Fj2J5NPo5ONhkeS?=
 =?us-ascii?Q?szV0sggDNNvlKdbT/oKBM4tyLsaWzBzOSh8PhwyAkmXT28vTiVEhGgFvPaAT?=
 =?us-ascii?Q?MXXyN4K0UgGvc/AsSTjDvZneqQgjUy/3RVnueJbT/9PdGjTvcjan4I4I0Jk2?=
 =?us-ascii?Q?WxSWt3r2JMNUhX2qZt2tdIzeGrCSBJkfIQZhRUDq2kP93stairNKlUnBwKwo?=
 =?us-ascii?Q?lxRIH9ZHFvQ2tZQTrBNq2HfnKEjR+6cfiAmwoDHxw0kzqvGEdhA4ap+mXse8?=
 =?us-ascii?Q?KNDkAjCmc7Y01JKIFKPP3YXadeKJy4HsBSfqo+bJeGKAzFrDF2IjzYYroK2N?=
 =?us-ascii?Q?A9Mhaq8FD4iiGecAo4TcTxLwTYVF7Fjh2fpvtuFO0ufvmlgLrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(48200799009)(82310400017)(376005)(7093399003)(35950700004)(61400799018)(921011)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:24:18.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0385bf-a251-4c43-7db0-08dc705d9ef3
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7981

Remove nuvoton,npcm845-clk binding since the NPCM8xx clock driver
using the auxiliary device framework and not the device tree framework.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml   | 49 -------------------
 1 file changed, 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
deleted file mode 100644
index b901ca13cd25..000000000000
--- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
+++ /dev/null
@@ -1,49 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Nuvoton NPCM8XX Clock Controller
-
-maintainers:
-  - Tomer Maimon <tmaimon77@gmail.com>
-
-description: |
-  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
-  generates and supplies clocks to all modules within the BMC.
-
-properties:
-  compatible:
-    enum:
-      - nuvoton,npcm845-clk
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-    description:
-      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
-      list of NPCM8XX clock IDs.
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    ahb {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        clock-controller@f0801000 {
-            compatible = "nuvoton,npcm845-clk";
-            reg = <0x0 0xf0801000 0x0 0x1000>;
-            #clock-cells = <1>;
-        };
-    };
-...
-- 
2.34.1


