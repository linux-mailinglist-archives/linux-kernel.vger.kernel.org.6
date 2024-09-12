Return-Path: <linux-kernel+bounces-327213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302097726D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872541C24167
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC81C1AC6;
	Thu, 12 Sep 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="j0Zk7Ti8"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2059.outbound.protection.outlook.com [40.95.54.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A09156F3C;
	Thu, 12 Sep 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170263; cv=fail; b=NfR+fKkQp6BZywN5zRU1H4ZEpxBaZkYhyfFLV2sc0cT2ovxASRgPlVxxQ7g06/w5dX4AzGBCIAsH5HWM4tLMGihDwATBvlEUhmzerArgmlHmJps4e/yq/F6dNkrPydLZF3YuTmd+xqK9+Tbyr8j+t/iFAkYLHUzeOcyQzsnfPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170263; c=relaxed/simple;
	bh=qFqGHgEyyN8yUWr0qjApPEVs20oo7ZhAYqawZjFsLxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7uYZ8AJdaBkx6elCRnRZP+dpfjns+mf8/HdxK6pOY3oPxmCKrfFlwbBLUysdUFICCmsernpUehVdpHudcuIu4yU29jYY+DhDHniaw022SThlhOj79+3LOs/Pr59eySKoW9W6Zy1XmIqNX6VzZk2M2/Hk3NgnL8ABrFZxHxDSlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=j0Zk7Ti8; arc=fail smtp.client-ip=40.95.54.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzFij9GVHqYM7yfgPD1w5XPEHbygLYuYI5ewZnWrNZ/XWVOkFSjCxhJaL43zkJ4KyLZMrDH0M0oUEePoURLpZGBnawp06dNgTUPpKbLcPdSdx1yI2Ci9mbXkdNOme299zaCX3DHvRbNxqnJIbEQFCtCn9Lt62lxo9fdqPOkenPRAxMLrhCgBkK663fU8hcTcOwdmajuqE0X68JMKjNB1ty3yg6ufoZdq7jsW+2JZbPxDa8JU5jFUGWNh5Jkx7MxmvNyDwBy3QcCuKAL7g35LJwG8xqOhote1ejm9REsEPAwa2aicyVy1ew6VjQYWtJSqfL802EgnX/yWcPMdmITVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=Ql8J3+g86xxSySDe6/FqG9uCnS/ugaVxfd6fo7ktsFJGlRjCNpyXmlV/BszwLy3mWUgrvhl9tu2KfCaJp/jo7eKKMWuHMGvkOCyaeaxR8Ls1Kubhs05kbl9OPlu3QlF7DbP/p6Y68eKtx0/MPrkzAluEZ5TffJA/ilfcjWYIXv6f9GWBZXmqxHW0NPekMmzP91uQbIfo3OqrFjG6GXIeB4lctHP9FPluIP30gMvjONS0STjoEr9HMdNgtkmspD+/7cTKaWLRwNT8pScueJnyyCLba72GOqW1LQj8ZeSOzLChNXa5czvdtJHEglihT8HfNtDdqwopu53O8ruHn58A3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsp6Fu2EwmNWI4JUeaL8+uK9d/eheOZNExD2CIqLPZk=;
 b=j0Zk7Ti8+R8tdPxFb9oEiF8bGF0AArNx38rhls1a4HKmM2VizTeXklrwj70JdFhzrOyHBK6IsKPq7xykue0e5aneAR/b7uA4tQqgV0gFqmXp98qxH6bQ9fDecCg23O5E2xC25SwVx1K9ueKDSKITbSrD9MUpmVL1c2vXL0TQhE4=
Received: from SI2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::22) by
 OSQPR03MB8525.apcprd03.prod.outlook.com (2603:1096:604:27f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 12 Sep 2024 19:10:44 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::b2) by SI2P153CA0006.outlook.office365.com
 (2603:1096:4:140::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.7 via Frontend
 Transport; Thu, 12 Sep 2024 19:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:10:41 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:10:40 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 172035F5DF;
	Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 099F7DC0AFB; Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v28 1/3] dt-bindings: reset: npcm: add clock properties
Date: Thu, 12 Sep 2024 22:10:36 +0300
Message-ID: <20240912191038.981105-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912191038.981105-1-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|OSQPR03MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: b13ddcea-fe15-49e3-2d04-08dcd35e98a0
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7093399012|35950700016|376014|48200799018|61400799027|7416014|82310400026|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgT0GRj0A2bCmQgKhohwicOTBrCAcwuIS1wXiVdhXrSRlyuJH5nO8NPeoszA?=
 =?us-ascii?Q?3TrIDR49lRj9RZGTdOapgx3nnFEVALgrdyprzYDSWJVP5La/8PiqnOD0tS7m?=
 =?us-ascii?Q?gmSenPB3R50sw8IJme979Atkmtk8WihnzTjdVsPwITXf9jUnmGFrSVZj93Hd?=
 =?us-ascii?Q?AsKyqfABc5T61488rK3JfxjzWTQQTie73aZGgOD9nCSInquM7HEM7ZRLlUqB?=
 =?us-ascii?Q?mwQsusn7BYHPyVe4PBiisP/MafJnY/OMUzrpTQTQzgc8YpjnxNslnSCkOSFK?=
 =?us-ascii?Q?WMHvrmFmdKpj6GUVAMKzYoudDN1L7rG5CvKyfjHcJsbqT9cjcPXAfNAk2s8j?=
 =?us-ascii?Q?+hk4eAhqg0e7qk0mJOEkrFFv0Lwz9UJmN4L0ZKzq/YwaSpV00ibdKVL0Te72?=
 =?us-ascii?Q?pk+gHpVnrWY10foeZAOPg/135q5eoT0BjHOk8ShFJKiEQUebPnBTJssyKxOY?=
 =?us-ascii?Q?ksWLtOgIF+2G+LXjvdcnCdgvzEMAAfziXgVkXh6n68FgnHGbJngqxeh7bFuU?=
 =?us-ascii?Q?NIV2ul1MbuD7PmEhwUFG9DMwu0rxBPo4I3yYiKAo6o7JrSuMyBo+KiX0i2Ec?=
 =?us-ascii?Q?Z7F+ki+a2NoISrEmZ+zhJXzB7eYEnCCh7v7FIc/88+4wHfVsfS1t7cRjMn3T?=
 =?us-ascii?Q?jkCCUG7tBCs/hNgc7Ei7RX3L94ujJ25l8KFajdsJ7g9t5IQ4KVzcGmNjxDdE?=
 =?us-ascii?Q?dPcMl2FQ9vSRXrcehHLzlMz5ceOBXH0BPkV8O39ZpTLHrKBqZkpC12UN8qpj?=
 =?us-ascii?Q?0plbSD8Q3VT6n4a9tA+1PxbOgaooaKyasLIbB6UXV+WZ51JGSs2TP1FAxHpK?=
 =?us-ascii?Q?Y7KsqLZUmSoq8zn5Vj4rGQxV4CVzjHhvmHo8TXU2lwhpJTrukhnIAz3ESbc4?=
 =?us-ascii?Q?UgfeR+kgo22zN9gl1qRc+MhqB9jo1FYc4kJpgCdkRycYWvN8CZsMW606buQp?=
 =?us-ascii?Q?44R/Yhv+O8LO42B0sqXdYExZIbPVH5fUGOyKjLFhPBnnzN9j8hnaQ41HCYJw?=
 =?us-ascii?Q?6S5SwkerSNkRwxBTlR3n4jYeR7n2unyAJbMBgbXMnGtEA1IhKRdu2HckZLdB?=
 =?us-ascii?Q?EjRPYFAeNF+/jEHODnBBnVIitQ8OEwnShqF7SxVBiWXYMF6McIa5NMHye6cX?=
 =?us-ascii?Q?rhELG061trHDCYUugv//HEosHTaghCSn/cCCK2304X4LVoJfi/t8Gx6P4o4L?=
 =?us-ascii?Q?Z/8i+Pnhq+2LcYwl4cXP1DThUlx2IaHBoRPpxyKbwilqP5rIEmniLmxGgF0d?=
 =?us-ascii?Q?C0OLRlvQ+AT2HrljA1BGSXsP28cgQ6N0OL2W3O0qC9fUxfkwZcqUV3QzUIhY?=
 =?us-ascii?Q?5O4XwLYminZhupscAo9/RGc5XkIZXzHQAOVXGrDYwgddLxMG4/OYJ1RghH8X?=
 =?us-ascii?Q?lmalABH8iM8JubSiKqlsE3W+yE0u3fwxSPKlPjCqwZVixh11BtkZ0weeqbQu?=
 =?us-ascii?Q?rAgURSggraiH+I6Kwx7pNmODA5x3qiuolb/y63zUdW7OrGQ/V+SgNUJZZ0lC?=
 =?us-ascii?Q?bpJgqY619XOTjyo=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7093399012)(35950700016)(376014)(48200799018)(61400799027)(7416014)(82310400026)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:10:41.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13ddcea-fe15-49e3-2d04-08dcd35e98a0
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8525

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


